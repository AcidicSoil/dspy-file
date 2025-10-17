# path: scripts\start_mlflow.ps1
# Idempotent MLflow local server startup script for PowerShell

$ErrorActionPreference = "Stop"

# Config
$MLFLOW_DB = "mlflow.db"
$ARTIFACT_DIR = "mlruns"
$MLFLOW_PORT = 5000

# Resolve directories
$SCRIPT_DIR = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$PROJECT_ROOT = Split-Path -Parent $SCRIPT_DIR
Write-Host "Project root resolved to: $PROJECT_ROOT"

# Paths
$MLFLOW_DB_PATH = Join-Path $PROJECT_ROOT $MLFLOW_DB
$ARTIFACT_DIR_PATH = Join-Path $PROJECT_ROOT $ARTIFACT_DIR

# Ensure mlflow CLI exists
if (-not (Get-Command mlflow -ErrorAction SilentlyContinue)) {
  Write-Error "mlflow CLI not found in PATH."
  exit 1
}

# Create artifact directory if missing
if (-not (Test-Path -Path $ARTIFACT_DIR_PATH -PathType Container)) {
  Write-Host "Creating artifact directory: $ARTIFACT_DIR_PATH"
  New-Item -ItemType Directory -Path $ARTIFACT_DIR_PATH | Out-Null
} else {
  Write-Host "Artifact directory '$ARTIFACT_DIR_PATH' already exists."
}

# Create empty SQLite DB file if missing
if (-not (Test-Path -Path $MLFLOW_DB_PATH -PathType Leaf)) {
  Write-Host "Creating empty MLflow backend DB file: $MLFLOW_DB_PATH"
  New-Item -ItemType File -Path $MLFLOW_DB_PATH | Out-Null
} else {
  Write-Host "MLflow backend DB '$MLFLOW_DB_PATH' already exists."
}

# Check if MLflow server is already running on port
$portInUse = $false
try {
  $portInUse = [bool](Get-NetTCPConnection -LocalPort $MLFLOW_PORT -State Listen -ErrorAction SilentlyContinue)
} catch {
  # Fallback for older systems
  $test = Test-NetConnection -ComputerName 'localhost' -Port $MLFLOW_PORT -InformationLevel Quiet
  $portInUse = $test
}

if ($portInUse) {
  Write-Host "MLflow server already running on port $MLFLOW_PORT. Skipping server start."
} else {
  Write-Host "Starting MLflow server on port $MLFLOW_PORT..."
  $backendUri = "sqlite:///" + ($MLFLOW_DB_PATH -replace '\\','/')
  $args = @(
    "server",
    "--backend-store-uri", $backendUri,
    "--default-artifact-root", $ARTIFACT_DIR_PATH,
    "--host", "0.0.0.0",
    "--port", "$MLFLOW_PORT"
  )
  Start-Process -FilePath "mlflow" -ArgumentList $args -NoNewWindow
  Write-Host "MLflow server started."
}
