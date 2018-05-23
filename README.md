<div align="center">
  <img src="logo.png" width="512">
</div>

---

<h1 align="center">
  CancerDiscover
</h1>

<h4 align="center">
  A data mining suite for cancer classification
</h4>

<p align="center">
  <a href="http://cancerdiscover.readthedocs.io">
    <img src="https://readthedocs.org/projects/cancerdiscover/badge/?version=latest"/>
  </a>
  <a href="https://saythanks.io/to/akram-mohammed">
    <img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg?style=flat-square">
  </a>
  <a href="https://paypal.me/akram9">
    <img src="https://img.shields.io/badge/Donate-%24-blue.svg?style=flat-square">
  </a>
</p>

**CancerDiscover** is an open source command line pipeline tool (released under the [GNU General Public License v3](LICENSE.md)) that allow users to efficiently and automatically process large high-throughput datasets by converting data (for example CEL files, etc.), normalizing, and selecting best performing features from multiple feature selection algorithms. The pipeline lets users apply different feature thresholds and various learning algorithms to generate multiple prediction models that distinguish different types and subtypes of cancer.

**Cite:**
[CancerDiscover: an integrative pipeline for cancer biomarker and cancer class prediction from high-throughput sequencing data](https://doi.org/10.18632/oncotarget.23511) 

*Mohammed, A., Biegert, G., Adamec, J., & Helikar, T. (2018). CancerDiscover: an integrative pipeline for cancer biomarker and cancer class prediction from high-throughput sequencing data. Oncotarget, 9(2), 2565–2573. doi:10.18632/oncotarget.23511*

***Note***: CancerDiscover is an open-source software, in case if you run across bugs or errors, raise an issue over [here](https://github.com/HelikarLab/CancerDiscover/issues).

### Table of Contents
* [System Requirements](#system-requirements)
* [Downloading CancerDiscover and Dependencies](#downloading-cancerdiscover-and-dependencies)
* [Directory Structure of the Pipeline](#directory-structure-of-the-pipeline)
* [Execution of Pipeline](#execution-of-pipeline)
* [Contribution](#contribution)
* [License](#license)

This README file will serve as a guide for using this software tool. We suggest reading through the document, in order to get an idea of the options available, and how to customize the pipeline to fit your needs.

### System Requirements
You will need current or very recent generations of your operating system: 
**Linux OS**, **Mac OSX**.

### Downloading CancerDiscover and Dependencies
```console
curl -sL bit.do/installation_linux | sh
curl -sL bit.do/installation_mac | sh
```
To install CancerDiscover dependencies right from scratch, check out our exhaustive guides:
* [A Hitchhiker's Guide to Installing CancerDiscover on Linux OS](https://github.com/HelikarLab/CancerDiscover/wiki/A-Hitchhiker's-Guide-to-Installing-CancerDiscover-on-Linux-OS)
* [A Hitchhiker's Guide to Installing CancerDiscover on Mac OS X](https://github.com/HelikarLab/CancerDiscover/wiki/A-Hitchhiker's-Guide-to-Installing-CancerDiscover-on-Mac-OS-X)

### Directory Structure of the Pipeline
* [Directory Structure](https://github.com/HelikarLab/CancerDiscover/wiki/Directory-Structure-of-the-Pipeline)

### Execution of Pipeline
* [Execution of pipeline](https://github.com/HelikarLab/CancerDiscover/wiki/Execution-of-CancerDiscover)

### Contribution

  Akram Mohammed	amohammed3@unl.edu
  
  Greyson Biegert	greyson@huskers.unl.edu
  
  Jiri Adamec		jadamec2@unl.edu

  Tomas Helikar		thelikar2@unl.edu

### License
This software has been released under the [GNU General Public License v3](LICENSE.md).
