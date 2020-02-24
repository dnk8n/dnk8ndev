---
title: Some recent side projects
date: 2020-02-24T08:41:57.790Z
tags:
  - tinkering
  - python
  - open-source
series:
  - projects
---
Some hobby projects I have worked on recently:

1.) ***A tool to run a script on a temporary Amazon AWS EC2 instance*** - [https://github.com/dnk8n/​remote-provisioner](https://github.com/dnk8n/remote-provisioner)

It was useful to me when building large Docker images while on slow internet connection. It makes use of [Terraform by Hashicorp](https://www.terraform.io) to provision a temporary instance with defaults that could be easily overridden and once ssh was active, execute build steps and perform bandwidth intensive uploads from within my Amazon AWS VPC.

2.) ***A plugin for [Orange data mining tool](https://orange.biolab.si/)*** - [https://gitlab.com/​dnk8n/orange-fastx](https://gitlab.com/dnk8n/orange-fastx)

It was useful to me when uploading source files of unsupported format. Written in Python 3, it subclassed an existing file widget class to handle formats of interest to me, [FASTA](https://en.wikipedia.org/wiki/FASTA_format) and [FASTQ](https://en.wikipedia.org/wiki/FASTQ_format)

3.) ***Convert integers to Roman Numerals*** - [https://gitlab.com/dnk8n/​any_roman](https://gitlab.com/dnk8n/any_roman)

I used this as an exercise to upload a Python package to PyPi, see [https://pypi.org/project/​any-roman](https://pypi.org/project/any-roman). I found most implementations had an upper positive integer constraint, I created an implementation that is designed to accept any positive integer. I also deployed it live using [Zeit Now](https://zeit.co/docs), a cloud service for serverless functions, see [https://api.dnk8n.dev/int_​to_roman/9999](https://api.dnk8n.dev/int_to_roman/9999) for example, where 9999 is an integer to be converted.

4.) **A proof-of-concept of a simple CRUD webservice, with database interacting with Amazon's [Aurora serverless postgres](https://aws.amazon.com/blogs/aws/amazon-aurora-postgresql-serverless-now-generally-available/) via their [RDS Data API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html)** - [https://gitlab.com/​dnk8n/postgres-serverless-now](https://gitlab.com/dnk8n/postgres-serverless-now)

The implementation is live at [https://postgres-​serverless.now.sh](https://postgres-serverless.now.sh/). Please note, that when DB has not had traffic in 5 minutes it is automatically paused and therefore billing is stopped, so if you visit it while in paused state, the DB is booted from cold and takes some time to display its contents (sometimes it can time out, in which case a refresh should work).

I did this to analyse the potentials of this cost model for SQL complient serverless databases. This could be useful for conveniently starting staging servers that one would otherwise not want to pay to keep live. Also for small websites. The cold start times are not very attractive but once they reduce to an acceptable level, this technology could be promissing.\

5.) ***A tool that parses any ISO 8601 complient datetime string*** - [https://gitlab.com/dnk8n/​simple-iso](https://gitlab.com/dnk8n/simple-iso)

According to the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard, it "supports the addition of a decimal fraction to the smallest time value in the representation." E.g. strings like '[2020-02-23T22:16:57.5](https://simple-iso.now.sh/8601/2020-02-23T22:16:57.5)', '[2020-02-23T22:16.5](https://simple-iso.now.sh/8601/2020-02-23T22:16.5)' and '[2020-02-23T22.5](https://simple-iso.now.sh/8601/2020-02-23T22.5)' should be supported. I couldn't find any libraries that could, so I made a simple Python 3 library that imports no external libraries to bring about this functionality. I uploaded it to PyPi, [https://pypi.org/project/​simple-iso](https://pypi.org/project/simple-iso/) which also includes a CLI and a [Flask](https://palletsprojects.com/p/flask) API that can provide information about the time string, see live deployment at [https://simple-iso.now.sh](https://simple-iso.now.sh/) which redirects to show information about the current time. I have also hyperlinked the example time strings above.
