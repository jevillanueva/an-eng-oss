
Configurar variables

```powershell
$pythonPath = (python -c "import sys; print(sys.executable)").Trim()
$env:PYSPARK_PYTHON = $pythonPath
$env:PYSPARK_DRIVER_PYTHON = $pythonPath
```
4. Execute a script

```powershell
python scripts/transform_dataframe.py
```

