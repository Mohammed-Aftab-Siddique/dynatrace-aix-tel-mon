# aix_tel_mon_v1.sh Documentation

## Overview
The `aix_tel_mon_v1` script is designed to monitor the telnet status of given targets from any give source (AIX servers). It provides observability to telnet status from aix source to dynatrace (pre-built extension not available).

## Configuration
To configure the script, you'll need to specify the following parameters:
- `DT_TENANT_URL` - Dynatrace tenant URL with environment ID.
- `DT_API_TOKEN` - Dynatrace PAAS token with Ingest.Metrics permission.
- `HOST_IP` - The host ip of the source.
- `TARGET_FILE` - Absolute path of the file which contains a list of targets.
- `TIMEOUT` - Timeout in seconds (INTEGER).
- `Metric Name` - Metric name to be configured in the payload (recommended format: custom.app_name...)

Ensure that the configuration values follow the required format to avoid issues during execution.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/Mohammed-Aftab-Siddique/dynatrace-aix-tel-mon.git
   ```
2. Navigate to the cloned directory:
   ```bash
   cd dynatrace-aix-tel-mon
   ```
3. Ensure that you have the necessary permissions to execute the script:
   ```bash
   chmod +x aix_tel_mon_v1.sh
   ```
## Metric Overview
Metric Name(s):
 ```bash
   custom.telnet.check
   ```
Metric Dimensions:
 ```bash
   source, target, port & time
   ```
Metric Value:
 ```bash
   status
   ```
4. Create a target file with the name `targets.txt`, in each line append target and port seperated with a space.
 ```bash
   touch /absolute/path/to/targets.txt
   ```
   
## Security Considerations
- Be aware of the sensitivity of the data being processed. Avoid exposing sensitive information in the output files.
- Run the script in a secure environment to prevent unauthorized access to the files.

## Troubleshooting
- **Permission Denied**: Check that the script has appropriate execution permissions.

## Examples
To run the parser on a log file, use the following command:
```bash
./aix_tel_mon_v1.sh
```

This command will process the specified log file and ingest an output to dynatrace.

# Version History

## aix_tel_mon_v1
- Initial Release

