1. Install Java Development Kit (JDK) on your local machine. "Eclipse Adoptium jdk-17.0.21.9"
2. Install PySpark on your local machine using requirements.txt
3. Execute show spark  `python -m pip show pyspark` to verify the installation.

Configurar variables

```powershell
$pythonPath = (python -c "import sys; print(sys.executable)").Trim()
$env:PYSPARK_PYTHON = $pythonPath
$env:PYSPARK_DRIVER_PYTHON = $pythonPath
```
4. Execute a script

```powershell
python scripts/spark_setup_check.py
```