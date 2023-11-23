# run_tests.py
import subprocess

# Run your tests with coverage
subprocess.run(['klayout', '-zz', '-r', 'coverage', 'run', '--source=/home/pymacros', 'pymacros/EBeam_Lib_PCellTests.py'], check=True)

# Generate the coverage report
subprocess.run(['coverage', 'xml', '-o', '/home/pymacros/coverage.xml'], check=True)
