# Inferring Fishing Effort from Lat-Lon Data
This software infers fishing effort distribution at a given input resolution based on punctual data that include, among the others, data of fishing vessel positions.

**Prerequisites:** download the [pre-coocked JAR file](https://data.d4science.org/shub/E_RmlXSjJSbFVhZmVyT25YTFJJYlY1a3BJRWc0T0xueUVIOWNXamR3dStNV3RMZDl2WThJRE5rckY0b1cwWVU1Kw==) from  https://github.com/cybprojects65/VariationalAutoencoder

**Main file:** [VTI2EffortWorkflow.R](https://github.com/cybprojects65/InferFishingEffortFromSatelliteData/blob/main/VTI2EffortWorkflow.R "VTI2EffortWorkflow.R")

## How to run

   0. Download the repository.
   1. Change the [config.properties](https://github.com/cybprojects65/InferFishingEffortFromSatelliteData/blob/main/config.properties "config.properties") file (see the given examples and follow the comments inside the file)
    2. Set the working directory to the VTI2EffortWorkflow.R folder
    3. Execute the script from RStudio or from the command line.
    4. Retrieve the output at the file specified in the "output_analysis"
    config parameter.
    5. Import the file in QGIS to visualize the average fishing effort
    estimated.
    6. Compare to the GFW data (included in the reference folder) or
    downloadable as geotifs from https://globalfishingwatch.org/
    7. Visualize the GFW reference data through the gfw_data variable.
