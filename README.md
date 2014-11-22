Jenkins Docker Image w/ GCloud SDK + additional Jenkins Plugins
====================================================

This image builds up on the official weekly Jenkins Docker Image [jenkins:weekly](https://registry.hub.docker.com/_/jenkins/).

Additionally installed:

* Oracle JDK 7 (latest at point of image build)

-

* Google Cloud SDK including several components
 * App Engine SDKs for Go, Java, Python and PHP
 * Cloud SDK for Go, Java, Python and PHP
 * Developer Preview Commands + Extensions
 * gcloud app Extensions for Go, Python

-

* Jenkins plugins
 * Job Configuration History
 * Parameterized Trigger
 * SSH Agent
 * SSH Credentials
 * SSH Slaves 
 * Maven
 * Git Client
 * Git Parameter
 * GitHub
 * GitHub API
 * GitHub Pull Request Builder
 * Environment Injector
 * Cloudbees Build Flow
 * Join
 * JsHint
 * JUnit
 * Metrics
 * Global Build Stats
 * Build Metrics
 * Disk Usage
 * Embeddable Build Status
 * Static Code Analysis
 * Static Analysis Collector 
 * Checkstyle
 * Duplicate Code Scanner (PMD)
 * DRY
 * FindBugs
 * Performance
 * Tasks Scanner
 * Warnings
 * Emma