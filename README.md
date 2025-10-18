
Methane Index Explorer (MIE) – Estimating Response to Selection for Methane Emissions
Repository URL: https://github.com/AgResearch/MIE
Author(s):  Pavithra C. Ariyarathne, Sharon M. Hickey, Timothy P. Bilton, Patricia Johnson, Natalie K. Pickering, Suzanne J. Rowe, and John C. McEwan
Date: January 16, 2025

**Overview**
MIE is an R-based software designed to estimate the response to selection for methane emissions using linear regression between the genomic estimated breeding values (GEBVs) of production and methane traits. This tool aims to aid researchers and breeders in selecting livestock with reduced methane emissions at the individual farm level by incorporating individual flock data while maintaining productivity and efficiency. This is an alternative approach for estimating selection response when the trait parameters are unknown. 

The software integrates GEBVs of individuals for each trait with the trait economic weights, and visualization tools to provide a comprehensive selection response analysis.

**Key Features**
Integrates GEBVs and Economic Values: Combines genomic breeding values and economic weightings for accurate response estimation.
Customizable Selection Scenarios: Users can modify input files to explore different breeding objectives.
Clear Output Visualizations: Generates comprehensive reports, including genetic trends and economic impacts.

**Creative Decisions & Justifications**
-Technology Stack
R packages: 'dplyr' for working efficiently with data frames for large-scale flock data, 'moments' for estimating skewness and kurtosis.
'ggplot2' for visualization of genetic trends and selection responses and, 'ggpubr' for visualization of density and QQ plot.

**Future Enhancements**
Integrate with Shiny for interactive user interfaces.

**Acknowledgments**
Special thanks to the farmers for dataset contributions, breeders for recording the methane traits, B+LNZ Genetics for the estimation of breeding values, and Focus Genetics Ltd. for funding the development of the MIE.

**Documentation**
For assistance with using MIE, please refer to the MIE_Manual.pdf.

**Citation**
To cite MIE: P. C. Ariyarathne, S. M. Hickey, T. P. Bilton, P. Johnson, N. K. Pickering, S. J. Rowe, and J. C. McEwan, 2025. Methane Index Explorer: Optimising a breeding value format for simultaneous inclusion of enteric methane emissions in breeding schemes and national inventories. Proceedings of the Association for the Advancement of Animal Breeding and Genetics. 26 (Accepted for publication).

**License & Copyright Statement**
License: Licensed under the GNU General Public License v3. See LICENSE for details.
Copyright Notice:
© 2025 Pavithra Ariyarathne/AgResearch. All rights reserved.  
This software and associated documentation are provided under the terms of the GNU GPLv3.  
Redistribution and use in source and binary forms, with or without modification,  
are permitted provided that the conditions of the GPLv3 are met.  
This software is provided "as-is," without warranty of any kind.  
