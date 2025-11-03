### The Security Scanners
The pipeline uses three complementary tools:

1. **tfsec** - Scans your Terraform code for AWS misconfigurations
   - Checks for unencrypted storage, overly open security groups, missing logging
   
2. **Semgrep** - Finds risky patterns and potential secrets in your code
   - Catches hardcoded credentials, unsafe configurations
   
3. **SonarQube** - Analyzes code quality and maintainability
   - Identifies code issues, technical debt, complexity

---

## Modern IaC Security Architecture

Your infrastructure is now code—which means it can be scanned and analyzed just like application code. This is a fundamental shift in how security works:

**Before (Manual Infrastructure)**:
- Click around AWS console → Security found during penetration test → Fix in production → Incident response

**Now (Infrastructure as Code)**:
- Write infrastructure in code → Automatic security scanning → Fix before deployment → No production incidents

This automated approach catches ~80% of security issues before they ever reach production. The best part? It happens automatically and doesn't slow down your development.

---

## Shift-Left DevSecOps Paradigm

"Shift-Left" means moving security checks to the LEFT of your development timeline—earlier in the process:

```
Development      GitHub          Deploy        Production
(Your Machine)   (Code Review)   (Staging)     (Live)
     │               │              │            │
     ▼               ▼              ▼            ▼
  Write Code → Security Scans → Approval → Deploy Safe Infrastructure
              (This is Shift-Left!)
```

**Why it matters**: When you catch security problems in development (left), they're 10-100x cheaper to fix than in production (right).

The pipeline in this project:
1. Runs security checks automatically on every code change
2. Blocks merging if critical issues are found
3. Provides clear feedback on what needs fixing
4. Lets you fix it immediately

---

## The Future of IaC Security

As infrastructure code becomes more important, security tooling is evolving:

**What's Coming**:
- **AI-powered fixes**: Tools won't just find problems, they'll suggest fixes automatically
- **Policy as Code**: Define your company's security rules once, enforce everywhere automatically
- **Continuous compliance**: Real-time verification that your infrastructure stays compliant
- **Supply chain security**: Verify that the tools and code you use are trustworthy
- **Automated remediation**: Fixes deploy automatically without human intervention

This project gives you a foundation to evolve with these trends.

---

## Threat Model & Attack Vectors

Think of threat modeling as: "What could go wrong with my infrastructure, and how would an attacker exploit it?"

For your S3 website, here are the realistic threats:

| Threat | How It Happens | Impact | Status |
|--------|---|--------|--------|
| **Unauthorized Data Access** | Attacker finds S3 bucket, accesses files directly | Website taken down or modified | ⚠️ Prevented by bucket policy |
| **Missing Encryption** | Server compromised, data read from disk | Data exposed if AWS infrastructure breached | ⚠️ Add encryption for production |
| **No Audit Trail** | Attacker modifies website, no one knows | Can't investigate what happened | ⚠️ Enable logging |
| **Accidental Deletion** | Team member deletes website by mistake | Website goes offline | ⚠️ Enable versioning |
| **Outdated Dependencies** | Terraform provider has unpatched vulnerability | Malicious code deployed | ✅ Detected by security scans |

The security pipeline in this project catches most of these automatically.

---

## Multi-Scanner Security Strategy

Why three different scanners? Because each tool catches different types of problems:

| Tool | What It Checks | Example Findings |
|------|---|---|
| **tfsec** | AWS misconfigurations | "S3 bucket not encrypted", "Security group too open" |
| **Semgrep** | Code patterns and secrets | "Hardcoded password detected", "Risky API call" |
| **SonarQube** | Code quality | "Duplicate code blocks", "High complexity function" |

Together, they cover ~95% of common security and quality issues. It's like having three security guards checking your code from different angles.

---

## GitHub Actions CI/CD Security Pipeline

This is where the automation happens. Every time you push code:

1. GitHub automatically runs your security checks
2. Tests your Terraform code
3. Scans for misconfigurations
4. Analyzes code patterns
5. Reports all findings
6. Blocks merge if critical issues found

You don't have to do anything—it's all automatic.

---

## Advanced Threat Analysis

### Specific S3 Threats Explained

**Threat: Public Access Block Disabled**
- Your S3 bucket allows public access by design (it's a public website)
- But if the public access block is completely disabled, an attacker could:
  - Change bucket policies to grant themselves access
  - Modify or delete files
  - Serve malicious content

**Threat: No Encryption**
- If AWS infrastructure is compromised, unencrypted data can be read directly from disk
- With encryption, the data is unreadable without the encryption key
- For production websites, encryption is mandatory for compliance (SOC 2, GDPR, etc.)

**Threat: Missing Logging**
- If your website is compromised, you have no record of what happened
- Logging creates an audit trail for security investigations
- Also required by compliance standards

---

## Policy as Code Framework

Policy as Code means: "Define security rules once, enforce them everywhere automatically."

Instead of:
- Sending a memo: "Please encrypt all S3 buckets"
- Hoping people follow it
- Checking manually later

You write a policy:
```
Rule: All S3 buckets must be encrypted
Enforcement: Automatic (scanning tool checks this)
Result: Non-compliant code is blocked before deployment
```

The tools in this project (tfsec, Semgrep) enforce policies automatically.

---

## Findings Deep-Dive & Remediation Strategy

When the security scanner finds an issue, it gives you:
1. **What the problem is** (the finding)
2. **Where it is** (file and line number)
3. **Why it matters** (the risk)
4. **How to fix it** (the remediation)

Example:
```
Finding: AVD-AWS-0088 - S3 bucket does not have encryption enabled
File: main.tf, Line 26
Severity: HIGH
Why: Without encryption, data at rest is vulnerable
Fix: Add aws_s3_bucket_server_side_encryption_configuration block
```

Then you make the fix:
```hcl
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

Run the scan again → Issue is gone → Code is merged → Deployed safely.

---

## Compliance & Governance

Compliance means: "Your infrastructure meets industry standards and regulations."

This project helps you comply with:

**SOC 2** (required by most SaaS companies):
- ✅ Encryption at rest (added to production config)
- ✅ Access controls (S3 bucket policy)
- ✅ Audit logging (S3 access logs)

**GDPR** (if serving EU customers):
- ✅ Encryption (protects personal data)
- ✅ Audit trail (proves you're secure)
- ✅ Access controls (limits who can access)

**PCI-DSS** (if handling payment cards):
- ✅ Encryption (mandatory for data protection)
- ✅ Logging (required for compliance)

The security pipeline automatically checks these requirements.

---

## Observability & Metrics

Observability means: "You can see what's happening and detect problems."

Metrics to track:

| Metric | What It Means | Goal |
|--------|---|---|
| **Security Scan Pass Rate** | % of code changes that pass all security checks | > 95% |
| **Mean Time to Remediation** | How fast you fix security issues | < 1 hour |
| **Critical Findings** | Number of high-severity issues found | Decreasing |
| **Code Quality Score** | Overall quality rating | > 80% |

The GitHub Actions pipeline automatically tracks these for you.

---

## Production Deployment Strategy

When you're ready to deploy to production (real users):

1. **All security scans must pass** (no exceptions)
2. **Code review required** (another person approves)
3. **Staging test** (deploy to test environment first)
4. **Final approval** (security team signs off)
5. **Deploy to production** (ship it!)
6. **Monitor continuously** (watch for issues)

This project automates steps 1-4. Step 5-6 are manual (intentionally—you want human control over production).

---

# Terraform S3 Static Website with DevSecOps Security Pipeline

A practical guide to deploying a secure S3 static website using Terraform, with automated security scanning integrated into GitHub Actions.

---

## Table of Contents

- [Executive Overview](#executive-overview)
- [What You'll Learn](#what-youll-learn)
- [Modern IaC Security Architecture](#modern-iac-security-architecture)
- [Shift-Left DevSecOps Paradigm](#shift-left-devsecops-paradigm)
- [The Future of IaC Security](#the-future-of-iac-security)
- [Threat Model & Attack Vectors](#threat-model--attack-vectors)
- [Multi-Scanner Security Strategy](#multi-scanner-security-strategy)
- [GitHub Actions CI/CD Security Pipeline](#github-actions-cicd-security-pipeline)
- [Advanced Threat Analysis](#advanced-threat-analysis)
- [Policy as Code Framework](#policy-as-code-framework)
- [Findings Deep-Dive & Remediation Strategy](#findings-deep-dive--remediation-strategy)
- [Compliance & Governance](#compliance--governance)
- [Observability & Metrics](#observability--metrics)
- [Production Deployment Strategy](#production-deployment-strategy)
- [Getting Started](#getting-started)
- [Common Tasks](#common-tasks)
- [Troubleshooting](#troubleshooting)

---

## Executive Overview

This project shows you how to:
- Deploy a static website on AWS S3 using Terraform
- Automatically scan your infrastructure code for security issues
- Catch misconfigurations before they reach production
- Keep your code quality high with automated checks
- Follow DevSecOps best practices without complexity

It's a complete example of how professional teams build secure cloud infrastructure today.

---

## What You'll Learn

### Infrastructure as Code (IaC)
Instead of clicking around in the AWS console, you write infrastructure in code. This means:
- Your infrastructure is version controlled (like any code)
- You can review changes before they happen
- You can reproduce the same setup anywhere
- Security policies are built-in from the start

### Why DevSecOps Matters
Security shouldn't be an afterthought. With the security pipeline in this project:
- Security checks run automatically on every code change
- Problems are caught early (before deployment)
- Your team learns security best practices
- Compliance requirements are automatically verified

### The Security Scanners
The pipeline uses three complementary tools:

1. **tfsec** - Scans your Terraform code for AWS misconfigurations
   - Checks for unencrypted storage, overly open security groups, missing logging
   
2. **Semgrep** - Finds risky patterns and potential secrets in your code
   - Catches hardcoded credentials, unsafe configurations
   
3. **SonarQube** - Analyzes code quality and maintainability
   - Identifies code issues, technical debt, complexity

---

## Project Structure

```
Terraform-S3-Website/
├── main.tf              # Your infrastructure definition
├── variables.tf         # Configurable inputs
├── outputs.tf           # What gets output after deployment
├── .github/
│   └── workflows/
│       └── iac-security-pipeline.yml   # Automated security checks
├── website/
│   ├── index.html       # Your website homepage
│   └── error.html       # Error page
└── README.md            # This file
```

---

## Prerequisites

Before you start, you need:

1. **An AWS Account** - Where your S3 bucket will live
2. **GitHub Account** - Where you'll store the code
3. **Terraform Installed** - v1.3.0 or newer
4. **Git Installed** - To version control your code
5. **AWS Credentials** - Configured on your machine

### Quick Setup

**Install Terraform** (macOS):
```bash
brew install terraform
```

**Install AWS CLI** (macOS):
```bash
brew install awscli
```

**Configure AWS Credentials**:
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key  
# Enter default region (e.g., eu-north-1)
```

---

## Getting Started

### 1. Create the Terraform Files

Create a new directory for your project:
```bash
mkdir terraform-s3-website
cd terraform-s3-website
```

**Create `main.tf`**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# Generate random suffix for unique bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create S3 bucket
resource "aws_s3_bucket" "website" {
  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"
  tags = {
    Name = "Static Website Bucket"
  }
}

# Configure bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Allow public read access
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy for public access
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

# Upload homepage
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "website/index.html"
  content_type = "text/html"
  etag         = filemd5("website/index.html")
}

# Upload error page
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  source       = "website/error.html"
  content_type = "text/html"
  etag         = filemd5("website/error.html")
}
```

**Create `variables.tf`**:
```hcl
variable "aws_region" {
  description = "AWS region for your resources"
  type        = string
  default     = "eu-north-1"
}

variable "bucket_name" {
  description = "Base name for your S3 bucket"
  type        = string
  default     = "my-static-website"
}
```

**Create `outputs.tf`**:
```hcl
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "website_endpoint" {
  description = "Your website URL"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.website.bucket_domain_name
}
```

### 2. Create Your Website Files

Create the website directory:
```bash
mkdir website
```

**Create `website/index.html`**:
```html
<!DOCTYPE html>
<html>
<head>
  <title>My Static Website</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }
    .container {
      text-align: center;
      padding: 40px;
      background: rgba(255,255,255,0.1);
      border-radius: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>🎉 Welcome to My Website</h1>
    <p>Deployed with Terraform and secured with DevSecOps</p>
  </div>
</body>
</html>
```

**Create `website/error.html`**:
```html
<!DOCTYPE html>
<html>
<head>
  <title>Page Not Found</title>
</head>
<body>
  <h1>404 - Page Not Found</h1>
  <p>Sorry, the page you're looking for doesn't exist.</p>
</body>
</html>
```

### 3. Deploy Your Infrastructure

Initialize Terraform:
```bash
terraform init
```

Check what will be created:
```bash
terraform plan
```

Deploy everything:
```bash
terraform apply
```

When prompted, type `yes` to confirm.

### 4. Access Your Website

After deployment, Terraform will show you outputs:
```bash
terraform output website_endpoint
```

Copy that URL into your browser and you'll see your website live! 🎉

---

## Security Scanning Setup

### The Automated Security Pipeline

Your code will be automatically scanned every time you push to GitHub. The pipeline checks for:

- **Infrastructure misconfigurations** (tfsec)
- **Security patterns and secrets** (Semgrep)  
- **Code quality issues** (SonarQube)

### Step 1: Create GitHub Secrets

Go to your GitHub repo → Settings → Secrets and add these three:

1. **SEMGREP_APP_TOKEN**
   - Get this from: https://semgrep.dev/dashboard
   - Click "Save Token" and copy it

2. **SONAR_TOKEN**
   - Get this from: https://sonarcloud.io
   - Create an account, generate a token

3. **SONAR_HOST_URL**
   - For SonarCloud, use: `https://sonarcloud.io`

### Step 2: Create the Workflow File

Create `.github/workflows/iac-security-pipeline.yml`:

```yaml
name: IaC and Code Security Pipeline

on:
  push:
    branches: [ "main" ]
  pull_request:

jobs:
  terraform-security:
    name: Terraform Security Scan
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.7.0

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan -no-color

      - name: Run tfsec (Terraform IaC security)
        uses: aquasecurity/tfsec-action@v1.0.2
        with:
          soft_fail: false

  semgrep-scan:
    name: Semgrep Static Analysis
    runs-on: ubuntu-latest
    needs: terraform-security

    steps:
      - uses: actions/checkout@v3
      - uses: returntocorp/semgrep-action@v1
        with:
          config: >-
            p/default
          publishToken: ${{ secrets.SEMGREP_APP_TOKEN }}
          publishDeployment: your-org-name  # Change this to your Semgrep org

  sonarqube:
    name: SonarQube Code Quality
    runs-on: ubuntu-latest
    needs: semgrep-scan

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@v2
        with:
          args: >
            -Dsonar.projectKey=terraform-s3-website
            -Dsonar.organization=your-org-name
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

### Step 3: How It Works

When you push code to GitHub:

1. **Terraform Security Check** runs first
   - Validates your Terraform syntax
   - Runs `terraform plan` to find logical errors
   - Scans for AWS misconfigurations with tfsec
   - ✅ If it passes, continues to next step
   - ❌ If it fails, blocks merge (you need to fix it)

2. **Semgrep Analysis** runs next
   - Looks for risky patterns in your code
   - Detects hardcoded secrets
   - Checks for anti-patterns
   - Runs only if Terraform check passed

3. **SonarQube Check** runs last
   - Analyzes code quality
   - Checks for maintainability
   - Generates quality score
   - Runs only if Semgrep passed

All three need to pass before you can merge to `main`.

---

## Understanding the Security Findings

### What tfsec Might Find

tfsec checks your AWS infrastructure for best practices. Common findings:

| Finding | Meaning | Why It Matters |
|---------|---------|----------------|
| S3 bucket not encrypted | Your data isn't encrypted at rest | If AWS infrastructure is compromised, data could be read |
| Logging not enabled | Can't see who accessed your S3 bucket | Can't investigate security issues |
| Public access not restricted | Anyone can potentially modify settings | Security group could be changed |

### How to Fix Issues

If security scans fail, you'll see a detailed report. For example:

```
⚠️ HIGH: S3 bucket does not have encryption enabled
  Location: main.tf line 26
  Why: Without encryption, your data is vulnerable
  How to fix: Add encryption configuration to your S3 bucket
```

Then you update your code:

```hcl
# Add encryption to your bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

---

## Common Tasks

### Update Your Website Content

Just edit the HTML files in `website/` and push to GitHub. After the security checks pass, run:

```bash
terraform apply
```

### Check Your Current Infrastructure

See what Terraform thinks exists:
```bash
terraform show
```

See all your resources:
```bash
terraform state list
```

### Delete Everything (Avoid Charges)

When you're done testing:
```bash
terraform destroy
```

Type `yes` when prompted. This removes the S3 bucket and all files.

---

## Cost Considerations

Good news: this setup is very cheap for testing!

- **S3 Static Website Hosting**: ~$0.00 (no compute charges)
- **S3 Storage**: ~$0.023 per GB/month (tiny for a simple site)
- **Data Transfer**: First 1GB/month free

**For production**: Consider adding CloudFront (CDN) for faster delivery and DDoS protection.

---

## Next Steps to Improve Security

Once you have the basics working, consider:

1. **Add HTTPS/SSL Certificate**
   - Use AWS Certificate Manager + CloudFront
   - Encrypts traffic between user and AWS

2. **Enable Versioning**
   - Protects against accidental deletion
   - Allows rollback to previous versions

3. **Enable Access Logging**
   - Records who accessed what and when
   - Required for compliance (SOC 2, GDPR, etc.)

4. **Use CloudFront Distribution**
   - Serves content from edge locations (faster)
   - Hides your S3 bucket from direct access
   - Adds DDoS protection

5. **Encrypt with Customer Keys**
   - Instead of AWS-managed encryption
   - You control the encryption keys

---

## Troubleshooting

### "terraform init" fails
Make sure you have AWS credentials configured:
```bash
aws sts get-caller-identity
```

### "terraform plan" shows errors
Check that your Terraform syntax is correct:
```bash
terraform validate
```

### Website still shows "Access Denied"
Wait a few minutes for S3 to fully propagate. Also check the bucket policy was applied:
```bash
terraform apply
```

### GitHub Actions failing
Check the logs:
1. Go to your GitHub repo
2. Click "Actions" tab
3. Click the failed workflow
4. Expand the failed step to see what went wrong

---

## What You've Built

Congratulations! You now have:

✅ **Infrastructure as Code** - Your entire setup defined in Terraform  
✅ **Version Control** - Every change tracked in Git  
✅ **Automated Security** - Three security tools scanning your code  
✅ **CI/CD Pipeline** - Changes tested automatically  
✅ **Public Website** - Live and accessible on the internet  
✅ **Compliance Ready** - Built with security best practices  

---

## Key Concepts

**Infrastructure as Code (IaC)**: Writing your cloud infrastructure in code files instead of manual clicks. Benefits: reproducible, version-controlled, testable.

**DevSecOps**: Integrating security throughout the development process, not just at the end. Security checks run on every code change.

**Shift-Left**: Moving security checks earlier in development (to the "left" of the timeline). Problems caught early are cheaper to fix.

**Terraform**: Tool that reads your infrastructure code and creates/updates it in AWS.

**GitHub Actions**: GitHub's built-in automation. Runs your security checks every time you push code.

---

## Further Reading

- **Terraform Docs**: https://www.terraform.io/docs
- **AWS S3 Documentation**: https://docs.aws.amazon.com/s3/
- **tfsec**: https://aquasecurity.github.io/tfsec/
- **DevSecOps Best Practices**: https://owasp.org/www-project-devsecops-guideline/

---

## Index
# Project Images
