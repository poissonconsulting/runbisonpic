<!---
Copyright 2023 Province of Alberta

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

### Run Model Help

Steps to run the model: 

1. Select the thinning.
2. Select the model mode.
3. Press the run button.
   - Model may take over 24 hours to run, be patient. 
   - The run is complete when the Outbox is populated with a table.
   - If there is an issue a pop-up box will appear indicating something is not valid, this must be fixed, and the run button will need to be pressed again to restart the model run.
   - The app has crashed and needs to be restarted if any of the following occur:
      - The screen goes grey and does not have a white spinner in the middle of the screen. 
      - A box appears in the bottom left corner saying disconnected.
      - An error message appears in the Console of RStudio.
4. Download the Analysis Object or Table and continue to the Results tab.

#### Parameters

##### Thinning

- Allowed values are an integer between 1 and 10000.
- Increase thinning if the model does not converge.
  - The model did not converge if the converged value in the output table is FALSE. 
- As the thinning value increases the run time will also increase. 
  - Start with a small thinning value and increase as needed. 
  - Thinning is often increased by various values try 1, 50, 100, 200, 500, 1000, etc.

##### Model Mode 

There are three model modes:

- quick
  - For testing the models runs.
  - Model results won’t be accurate, but this mode is helpful when first running the model to ensure everything is running correctly.
  - Run includes 2 chains and 10 iterations. 
- report 
  - This is a full run of the model. 
  - This mode will take much longer then quick mode. 
  - Run includes 3 chains and 500 iterations.
- debug
  - Verbose output for debugging.
  - Use this mode if errors are occurring and more help is needed.
  - Read the messages printed to the Console of RStudio to determine what is going on. 
  - Run includes 2 chains and 10 iterations. 

#### Description of Table

**n**

- Sample size.

**K**

- Number of parameter terms in the model.

**nchains**

- The number of chains.

**niters**

- Number of iterations. 
- A count of the number of simulations to save per chain.

**nthin**

- How much the chains should be thinned out before storing them.
  - Setting nthin = 1 corresponds to keeping all values.
  - A value of nthin = 100 would result in keeping every 100th value and discarding all other values.

**ess**

- Effective sample size (ess).
- The number of independent samples with the same estimation power as the n autocorrelated samples.
- Measure of how much independent information there is in autocorrelated chains.
- Doubling the thinning rate doubles the ess.

**rhat**

- A ratio of variances that compares the between- and within-chain estimates for model parameters.
- Evaluates whether the chains agreed on the same values.
- As the total variance of all the chains shrinks to the average variance within chains, r-hat approaches 1 (close to 1 is ideal).

**converged**

- Whether or not the model converged. 
  - Determines whether the model chains agreed on the same values.
- TRUE
  - This indicates the model converged.
  - A model must converge for the results to considered accurate. 
- FALSE
  - This indicates the model did not converge.
  - The model should be run again with different parameters or more data until the model converges.
  - Results may not be accurate if the model did not converge.

#### Download Options

After a successful run of the model two download buttons will appear in the top left of the Output box.

- Analysis Object
  - Download the output of the model run as a rds file.
  - This allows users to use the output of the model after the app closes.
- Table
  - Download the output table as a .csv file.  

#### Helpful Tips

- If you set the thinning to 1 and model mode to quick you can get a quick run of the model. This can help to make sure there are no issues with the data before doing a report run that may take a day or more to run. 
