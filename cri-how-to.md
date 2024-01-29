# Using Randi, the Center for Research Informatics (CRI) Computing Cluster

Randi is similar to Midway, with a few advantages:
- There is no maximum job length, so you can run jobs as long as needed.
- As of yet, we do not apply via allocation, so we can for now run as much as we desire. We do have a (300 GB) allocation for data, which cannot be exceeded unless we request more. Fees will be incurred if we ask for allocations beyond the 3TB limit and perhaps before.
- CRI does help via a slack channel (criscientific) which is not a piad slack account, so there is no record of past questions.
- As of January 2024, CRI and Randi does not yet have a "user guide" online, so a lot of the basic questions you might get easily answered on Midway that have no available answer on CRI. I recommend starting with the same commands used in Midway and just modifying for CRI, as these often work.
- You do not automatically get a Randi account, as you need to first request a BSD account and username. This is step one, and then you subsequently apply to join the brooklab compute space. See the CRI website for details [here](https://cri.uchicago.edu/hpc/).

CRI Randi is very similar to Midway, so I will not repeat all the information from the [Midway How-To](https://github.com/brooklabteam/lab-resources/blob/main/midway-how-to.md) here but will instead just highlight a few key differences.



Next, follow these instructions for a quick-start 'step-by-step' 'how-to' after you have established a Randi account (note that all of these assume your account name is 'cbrook' - you will need to substitute in your own account name to make them work):

1. To use Randi, you need to be logged onto the UChicago VPN or you need to be on campus.
2. Once on the VPN, open Terminal and ssh into Randi: 

	ssh cbrook@randi.cri.uchicago.edu
	
Password is your CNET ID password. No two-factor authentication is required here.

2. Then, follow the same commands as you use in Midway, only here adopted to CRI.
3. To run RaxMl, load as follows:

```
module load gcc/12.1.0
module load raxml/8.2.12
```
