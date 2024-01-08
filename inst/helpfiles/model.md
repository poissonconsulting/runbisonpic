### Run Model Help

#### Parameters

##### Thinning

An integer between 1 and 10000.

##### Model Type 

There are three model types:

- report 
  - This is a full run of the model. 
- quick
  - For testing that the models runs. 
- debug
  - Verbose output for debugging.

#### Run 

Model may take over 24 hours to run, be patient. 

#### Description of Table

**n**

**K**

**nchains**

**niters**

**nthin**

- How much the chains should be thinned out before storing them.
  - Setting nthin = 1 corresponds to keeping all values.
  - A value of nthin = 100 would result in keeping every 100th value and discarding all other values.

**ess**

**rhat**

**coverage**

#### Helpful Tips

- If you set the thinning to 1 and model type to quick you can get a quick run of the model. This can help to make sure there are no issues with the data before doing a report run that may take a day or more to run. 
