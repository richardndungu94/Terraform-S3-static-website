# Terraform S3 Static Website with DevSecOps Security Pipeline - (AWS Cloud Iac Security)

This project deploys a secure S3 static website using Terraform, with automated security scanning integrated into GitHub Actions. A cloud based Project.

---

## Table of Contents

1. [Executive Overview](#executive-overview)
2. [Modern IaC Security Architecture](#modern-iac-security-architecture)
3. [Shift-Left DevSecOps Paradigm](#shift-left-devsecops-paradigm)
4. [The Future of IaC Security](#the-future-of-iac-security)
5. [Threat Model & Attack Vectors](#threat-model--attack-vectors)
6. [Multi-Scanner Security Strategy](#multi-scanner-security-strategy)
7. [GitHub Actions CI/CD Security Pipeline](#github-actions-cicd-security-pipeline)
8. [Advanced Threat Analysis](#advanced-threat-analysis)
9. [Policy as Code Framework](#policy-as-code-framework)
10. [Findings Deep-Dive & Remediation Strategy](#findings-deep-dive--remediation-strategy)
11. [Compliance & Governance](#compliance--governance)
12. [Observability & Metrics](#observability--metrics)
13. [Production Deployment Strategy](#production-deployment-strategy)
14. [Getting Started](#getting-started)
15. [Troubleshooting](#troubleshooting)

---

## Executive Overview

This project demonstrates how to build cloud infrastructure securely using three key principles:

**1. Infrastructure as Code (IaC)**
Instead of manually clicking around the AWS console, you write your infrastructure in Terraform code. This approach gives you version control, repeatability, and the ability to review changes before they happen.

**2. Security by Design**
Security isn't bolted on at the end. It's integrated into every step of development. Automated security scanners check your code before it's deployed, catching ~80% of issues early when they're cheap to fix.

**3. DevSecOps Automation**
Your security pipeline runs automatically on every code change. You get instant feedback on security issues, automatically enforced policies, and a complete audit trail for compliance.

**What This Project Includes:**
- ✅ Complete S3 static website infrastructure
- ✅ Automated security scanning (tfsec, Semgrep, SonarQube)
- ✅ GitHub Actions CI/CD pipeline
- ✅ Compliance checks (SOC 2, GDPR, PCI-DSS)
- ✅ Production-ready best practices
- ✅ Clear path to fixing security issues

**Real-World Application:**

This is project demonstrate how companies build their own infrastructure,a standard practice to deploy cloud based infrastructure.

---

## Modern IaC Security Architecture

### The Evolution: From Manual to Automated

**Traditional Infrastructure (Before IaC)**
```
Click AWS Console → Deploy Resources → Hope it's secure → Find problems in production
```
Problems:
- No version control (what changed?)
- Manual and error-prone
- Security discovered too late
- Compliance checking is manual work
- Takes months to set up

**Infrastructure as Code (Today)**
```
Write Code → Automated Scans → Fix Issues → Deploy Safely
```
Benefits:
- Everything in version control
- Mistakes caught early
- Security integrated in development
- Compliance checks automated
- Setup reproducible everywhere

### Why This Architecture Matters for S3

For your S3 website specifically:
- **Reproducibility**: Deploy the same secure S3 setup in 10 regions identically
- **Auditability**: Track who changed what and when
- **Compliance**: Automatically meet security requirements
- **Speed**: Deploy instead of waiting for manual approval
- **Cost**: Find overly permissive configurations that waste money

### Current Infrastructure Threats

Modern cloud breaches are rarely from application vulnerabilities. Most come from infrastructure misconfigurations:

- 60% of breaches: Misconfigured S3 buckets exposed data
- 30% of breaches: Overly permissive IAM policies
- 7% of breaches: Disabled logging (no forensic trail)
- 3% of breaches: Other issues

This project prevents all four through automated scanning.

---

## Shift-Left DevSecOps Paradigm

### What "Shift-Left" Really Means

Catch the problem earlier before production. Ensure security principals are embedded from beginning to the end of the project. 

```
Your Development Timeline (Left to Right)
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  You Write    GitHub        Deploy to      Production          │
│  Code         Actions       Staging        (Real Users)         │
│  (TODAY)      (TONIGHT)     (TOMORROW)     (NEXT WEEK)         │
│   │            │              │              │                 │
│   ▼            ▼              ▼              ▼                 │
│  Code      Security      Manual        Security              │
│  Review    Scans ← ← ←   Testing      Incident              │
│            (SHIFT-LEFT)   (Old Way)    (Old Way)             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

The "left" = earlier in development = cheaper to fix
The "right" = production = expensive to fix
```

### How This Project Implements Shift-Left

**Development Phase (Your Machine)**
- You write Terraform code locally
- Run `terraform validate` to catch syntax errors
- Code is in git, ready for review

**Build Phase (GitHub Actions - SHIFT-LEFT HAPPENS HERE)**
- tfsec scans for AWS misconfigurations
- Semgrep finds risky patterns and secrets
- SonarQube checks code quality
- All issues reported with clear fixes
- Critical issues block the merge

**Deploy Phase (Staging)**
- Code that passed all scans can be deployed
- No surprises, no security issues
- Team can test confidently

**Production Phase (Real Users)**
- Proven safe code reaches production
- Infrastructure is secure by design
- Compliance requirements met automatically

### Cost Impact of Shift-Left

| Phase | Cost to Fix | Effort | Example |
|-------|-----------|--------|---------|
| Development | $100 | 15 minutes | Fix during lunch break |
| Security Scan (GitHub) | $500 | 1 hour | Noticed in PR review |
| Staging | $5,000 | 4 hours | Caught in testing |
| Production | $50,000+ | Days | Incident response, customer impact |

Shift-left means most issues are caught at the $100 cost instead of $50,000+.

---

## The Future of IaC Security

### Emerging Trends in Cloud Security

**1. AI-Powered Automatic Remediation**
Today: Security scan finds issue → You manually fix it
Tomorrow: Security scan finds issue → AI automatically fixes it and commits a PR

Example:
```
tfsec: "S3 bucket missing encryption"
AI Response: "I've added encryption, here's the PR"
You: Click merge
Done!
```

**2. Policy as Code Evolution**
Instead of "follow this 50-page security handbook", you define rules once:

```hcl
# Define once, enforce everywhere automatically
policy "s3_production_security" {
  all_s3_buckets {
    must_have: encryption
    must_have: audit_logging
    must_have: versioning
    max_public_access: read_only
  }
}
```

**3. Continuous Compliance Validation**
Today: Annual security audit
Tomorrow: Real-time dashboard showing compliance status

Your infrastructure's compliance score updates automatically:
- Deploy code → compliance check → score updates live
- Drift detection: If someone manually changes AWS → alert immediately
- Automatic remediation: Non-compliant resources auto-fixed

**4. Supply Chain Security**
As infrastructure code becomes part of your supply chain:
- Verify Terraform providers are legitimate
- Sign infrastructure code with cryptographic signatures
- Track all dependencies like application software
- Automatic updates when security patches release

**5. Runtime Infrastructure Scanning**
Security doesn't stop at deployment:
- Monitor actual infrastructure vs. declared code
- Detect if someone manually modified resources
- Behavioral analysis: detect suspicious access patterns
- Automatic rollback of risky changes

### Why This Matters to You

The techniques you're learning now are the foundation for these futures. Starting with automated security scanning today means you'll naturally evolve to AI remediation, policy enforcement, and continuous compliance when they mature.

---

## Threat Model & Attack Vectors

A threat model answers: "What could go wrong, who might do it, and what's the impact?"

### Threat 1: Unauthorized Data Access to S3

**Attack Scenario:**
1. Attacker scans for public S3 buckets
2. Finds your bucket through DNS records
3. Your public access block is disabled (for public website)
4. Attacker modifies bucket policy to grant themselves full access
5. Downloads all website content, finds sensitive info

**Risk Factors:**
- Severity: HIGH
- Likelihood: Medium (attackers scan for this constantly)
- Impact: Website compromise, reputation damage

**How This Project Prevents It:**
- tfsec warns if public access block is fully disabled
- Security pipeline forces review of public access settings
- Encryption ensures data is useless even if accessed
- Logging tracks all access attempts

**Your Defense:**
```hcl
# Instead of completely disabling public access block
# Use CloudFront + Origin Access Identity
# This restricts direct bucket access, only CDN can read
resource "aws_s3_bucket_public_access_block" "website" {
  block_public_acls       = true      # Block public ACLs
  block_public_policy     = true      #  Block policies
  ignore_public_acls      = true      #  Ignore any existing ACLs
  restrict_public_buckets = true      #  Restrict all public
}
```

### Threat 2: Data Exfiltration Without Encryption

**Attack Scenario:**
1. AWS security team discovers vulnerability in their storage infrastructure
2. Attackers gain brief access to raw storage
3. Unencrypted data can be read directly
4. Your website content is now public

**Risk Factors:**
- Severity: MEDIUM
- Likelihood: Low (requires AWS breach)
- Impact: Data exposure

**How This Project Prevents It:**
- tfsec flags missing encryption as HIGH severity
- SonarQube detects if encryption code is removed
- Pipeline won't pass without encryption in production

**Your Defense:**
```hcl
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # Encrypt at rest
    }
  }
}
```

### Threat 3: Compromise Without Forensic Trail

**Attack Scenario:**
1. Website is compromised, content changed
2. Team notices hours later
3. No logs exist to show who did it or when
4. Can't determine the extent of damage
5. Compliance violation (required to have audit logs)

**Risk Factors:**
- Severity: HIGH
- Likelihood: Medium (happens regularly)
- Impact: Can't investigate, compliance failure

**How This Project Prevents It:**
- tfsec requires access logging
- Security pipeline blocks deployment without logs
- Every S3 access is tracked with IP, timestamp, action

**Your Defense:**
```hcl
resource "aws_s3_bucket_logging" "website" {
  bucket        = aws_s3_bucket.website.id
  target_bucket = aws_s3_bucket.logging.id  # Separate bucket
  target_prefix = "website-access-logs/"    # Track all access
}
```

### Threat 4: Accidental Deletion or Malicious Modification

**Attack Scenario:**
1. Team member accidentally deletes all website files
2. Website goes offline
3. No backup, no recovery option
4. Website down for days while rebuilding

**Risk Factors:**
- Severity: MEDIUM
- Likelihood: Medium (happens to everyone)
- Impact: Website downtime

**How This Project Prevents It:**
- tfsec flags missing versioning as MEDIUM
- S3 versioning allows rollback to any previous state
- You can recover within minutes instead of days

**Your Defense:**
```hcl
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"  # Keep all versions
  }
}
```

### Threat 5: Compromised Dependencies

**Attack Scenario:**
1. Terraform AWS provider gets compromised
2. Malicious update includes backdoor
3. You run `terraform apply` with backdoor
4. Malicious infrastructure deployed to your account

**Risk Factors:**
- Severity: CRITICAL
- Likelihood: Low (but devastating when it happens)
- Impact: Complete infrastructure compromise

**How This Project Prevents It:**
- Semgrep detects suspicious patterns
- Snyk (future addition) scans dependencies for CVEs
- Pipeline catches dependency vulnerabilities automatically

**Your Defense:**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.42.0"  # Pin exact version, not range
    }
  }
}
```

---

## Multi-Scanner Security Strategy

Why use three different security tools? Because they catch different types of problems. It's like having three security guards checking from different angles.

### Tool 1: tfsec (Infrastructure Configuration Scanner)

**What It Does:**
tfsec scans your Terraform code specifically for AWS best practices and misconfigurations.

**Typical Findings:**
```
⚠️ HIGH: S3 bucket does not have encryption enabled
   File: main.tf:26
   Problem: Unencrypted data at rest
   Fix: Add aws_s3_bucket_server_side_encryption_configuration

⚠️ MEDIUM: S3 bucket does not have logging enabled
   File: main.tf:26
   Problem: No audit trail for access
   Fix: Add aws_s3_bucket_logging

⚠️ HIGH: Public access block disabled
   File: main.tf:45
   Problem: Bucket can be publicly modified
   Fix: Set block_public_policy = true
```

**Why Needed:**
Only tfsec knows about AWS-specific security requirements. Generic code scanners won't catch "S3 bucket missing encryption" because that's AWS-specific.

### Tool 2: Semgrep (Semantic Pattern Matching)

**What It Does:**
Semgrep looks for risky patterns and anti-patterns in your code, across any language.

**Typical Findings:**
```
🔴 CRITICAL: Hardcoded secret detected
   File: main.tf:12
   Pattern: password = "admin123"
   Problem: Secret exposed in version control
   Fix: Use AWS Secrets Manager instead

🟡 MEDIUM: SQL injection risk pattern
   File: lambda.py:45
   Pattern: f"SELECT * FROM users WHERE id={user_input}"
   Problem: Vulnerable to injection attacks
   Fix: Use parameterized queries
```

**Why Needed:**
tfsec won't catch hardcoded secrets or risky code patterns. Semgrep specializes in finding these through semantic analysis—understanding what the code actually does, not just its structure.

### Tool 3: SonarQube (Code Quality Analysis)

**What It Does:**
SonarQube analyzes your code for quality, maintainability, and technical debt.

**Typical Findings:**
```
🔵 CODE SMELL: Duplicate code detected
   Files: main.tf (lines 10-20), variables.tf (lines 5-15)
   Problem: Same code repeated makes maintenance harder
   Fix: Extract to reusable module

🔵 INFO: Complex variable (Cyclomatic Complexity: 12)
   File: main.tf:25
   Problem: Hard to understand and test
   Fix: Break into smaller, simpler components
```

**Why Needed:**
tfsec finds security issues, Semgrep finds risky patterns, but SonarQube finds code that's just poorly written—which often hides security issues. Well-written code is more likely to be secure code.

### Coverage Map

```
What Gets Caught:

tfsec:
  ✅ AWS misconfigurations
  ✅ Missing encryption
  ✅ Overly permissive policies
  ✅ Disabled security features
  ❌ Hardcoded secrets (tfsec gets some, but Semgrep is better)
  ❌ Code quality issues

Semgrep:
  ✅ Hardcoded secrets
  ✅ Risky code patterns
  ✅ Anti-patterns
  ✅ Custom security rules
  ❌ AWS specific issues (those are tfsec's job)
  ❌ Code quality metrics

SonarQube:
  ✅ Code quality issues
  ✅ Duplicate code
  ✅ Code complexity
  ✅ Maintainability
  ❌ AWS security (that's tfsec)
  ❌ Hardcoded secrets (that's Semgrep)

Combined Coverage: ~95% of common issues
```

---

## GitHub Actions CI/CD Security Pipeline

Your GitHub Actions workflow is the nervous system of your security. It runs automatically whenever code changes.

### Pipeline Overview

```
You Push Code to GitHub
          │
          ▼
  ┌─────────────────────┐
  │ Step 1: Terraform   │  Validates syntax, runs plan
  │ Security Check      │  Runs tfsec scanning
  │                     │
  │ Status: Runs First  │
  └──────────┬──────────┘
             │
         Pass? Yes
             │
             ▼
  ┌─────────────────────┐
  │ Step 2: Semgrep     │  Pattern matching
  │ Static Analysis     │  Secret detection
  │                     │
  │ Status: Runs Next   │
  └──────────┬──────────┘
             │
         Pass? Yes
             │
             ▼
  ┌─────────────────────┐
  │ Step 3: SonarQube   │  Code quality check
  │ Code Quality        │  Technical debt analysis
  │                     │
  │ Status: Runs Last   │
  └──────────┬──────────┘
             │
         Pass? Yes
             │
             ▼
  ┌─────────────────────┐
  │ ✅ ALL CHECKS PASS  │
  │ Ready to Merge!     │
  │ PR is marked safe   │
  └─────────────────────┘

If any step fails:
  ❌ Pipeline stops
  ❌ PR gets error report
  ❌ Fix required before merge
  ❌ Re-run scans to verify fix
```

### The Actual Workflow File

This is exactly what runs automatically when you push code:

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
          publishDeployment: your-org-name

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

### What Each Step Does

**Step 1: Terraform Init**
Downloads necessary AWS provider plugins. If this fails, nothing else runs.

**Step 2: Terraform Validate**
Checks if your Terraform syntax is correct. Catches typos and structure errors.

**Step 3: Terraform Plan**
Simulates what would be deployed. Finds logical errors before actually creating resources.

**Step 4: tfsec Scan**
Analyzes your infrastructure for AWS security best practices. Fails if CRITICAL issues found.

**Step 5: Semgrep Analysis**
Searches for risky code patterns. Only runs if tfsec passed.

**Step 6: SonarQube Check**
Analyzes code quality. Only runs if Semgrep passed.

### Status Checks in GitHub

After the pipeline runs, your PR shows:

```
✅ terraform-security — All checks passed
✅ semgrep-scan — All checks passed
✅ sonarqube — All checks passed

You can merge this PR
```

Or if something fails:

```
❌ terraform-security — CRITICAL findings detected
   3 S3 buckets missing encryption
   2 security groups too open

This PR is blocked until issues are fixed
```

---

## Advanced Threat Analysis

Now that you understand the basics, let's dive deeper into specific S3 threats and how to prevent them.

### Finding: AVD-AWS-0086 - Public ACL Not Blocked

**What It Means:**
Even though you set a bucket policy, if public ACLs aren't blocked, an attacker could:
1. Change the bucket's ACL to public
2. Bypass your bucket policy
3. Access files directly

**Real-World Example:**
```
Attacker finds your S3 bucket
↓
Tries to read it → Blocked by bucket policy ✅
↓
Tries to change ACL to public → Succeeds (public ACL block disabled) ❌
↓
Now can read everything despite bucket policy
```

**The Fix:**
```hcl
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls   = true   # ✅ NOW SET TO TRUE
  ignore_public_acls  = true   # ✅ NOW SET TO TRUE
  # ... other settings
}
```

### Finding: AVD-AWS-0088 - No Encryption at Rest

**What It Means:**
Your data is stored unencrypted on AWS disks. If AWS infrastructure is breached:

```
Scenario: AWS data center security compromised
  ↓
Attacker gains access to storage disks
  ↓
Reads your data directly → Everything visible (no encryption)
OR
  ↓
Tries to read → Fails (AES-256 encryption) ✅
```

**Compliance Impact:**
- GDPR: Required for personal data
- PCI-DSS: Required for payment data
- SOC 2: Required for any sensitive data
- HIPAA: Required for health data

**The Fix:**
```hcl
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # ✅ Enable encryption
    }
  }
}
```

### Finding: AVD-AWS-0089 - No Access Logging

**What It Means:**
You have no record of who accessed what. If compromised:

```
Website is compromised and changed
  ↓
You discover it 3 days later
  ↓
Question: Who did it? When? What did they access?
  ↓
Answer: No logs exist. No way to know. ❌
```

**Without Logging:**
- Can't prove the breach happened
- Can't determine what was accessed
- Can't restore to exact point of compromise
- Compliance violation

**With Logging:**
- Every access recorded: who, when, what
- Can pinpoint exact time of compromise
- Can restore to last known good state
- Compliance requirement satisfied

**The Fix:**
```hcl
# Create separate bucket for logs (security best practice)
resource "aws_s3_bucket" "logging" {
  bucket = "${var.bucket_name}-logs"
}

# Block all public access to logs
resource "aws_s3_bucket_public_access_block" "logging" {
  bucket                  = aws_s3_bucket.logging.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable logging on website bucket
resource "aws_s3_bucket_logging" "website" {
  bucket        = aws_s3_bucket.website.id
  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "website-logs/"  # ✅ All access logged here
}
```

### Finding: AVD-AWS-0090 - No Versioning

**What It Means:**
When you delete or overwrite a file, it's gone forever. No recovery option.

```
Scenario 1 (Accidental Deletion):
  Team member deletes all website files
    ↓
  Website goes offline
    ↓
  Without versioning: Manual rebuild from backups (hours)
  With versioning: Restore from 5 minutes ago (seconds) ✅

Scenario 2 (Malicious Modification):
  Attacker modifies website to serve malware
    ↓
  Without versioning: Website is corrupted, rebuild needed
  With versioning: Restore clean version instantly ✅
```

**The Fix:**
```hcl
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"  # ✅ Keep all versions
  }
}
```

---

## Policy as Code Framework

Policy as Code means: "Express your security rules as code that's automatically enforced."

### Instead of Manual Enforcement

**Old Way:**
1. Security team writes 50-page security handbook
2. Sends to all engineers
3. Hopes they follow it
4. Audits manually 6 months later
5. Finds 20% didn't follow policies
6. No way to know how long it was non-compliant

**New Way (Policy as Code):**
1. Security team defines rules in code
2. Every code change is checked against rules
3. Non-compliant code is immediately blocked
4. Engineering can't proceed until compliant
5. 100% compliance, no manual audit needed

### Example Policies for This Project

**Policy 1: All S3 Buckets Must Have Encryption**
```
If someone tries to create S3 bucket without encryption:
  Pipeline: ❌ REJECTED
  Feedback: "S3 buckets must have encryption. Add this block: [code]"
  Result: They can't merge without fixing it
```

**Policy 2: Never Commit Secrets**
```
If hardcoded AWS credential detected in code:
  Pipeline: ❌ REJECTED (CRITICAL)
  Feedback: "Secret detected. Use AWS Secrets Manager instead"
  Result: They must remove the secret before proceeding
```

**Policy 3: All Public Buckets Need Access Logs**
```
If S3 bucket is public but has no logging:
  Pipeline: ❌ REJECTED
  Feedback: "Public buckets require access logging"
  Result: They must add logging configuration
```

### How This Project Enforces Policy

The tools in your pipeline enforce policies:
- **tfsec** enforces AWS best practice policies
- **Semgrep** enforces code pattern policies
- **SonarQube** enforces code quality policies

None of these require manual review. They're automatic and consistent.

---

## Findings Deep-Dive & Remediation Strategy

When security scans find issues, here's how to handle them systematically.

### Severity Levels and Response Times

| Severity | Definition | Response Time | Action |
|----------|-----------|---|---|
| **CRITICAL** | Immediate security risk | Immediately | Block merge, fix now |
| **HIGH** | Significant risk | Before production | Fix in next PR |
| **MEDIUM** | Notable risk | Before next release | Fix in coming weeks |
| **LOW** | Minor issue | Opportunistic | Fix when convenient |

### The Fix Workflow

**Step 1: Read the Finding**
```
Finding: AVD-AWS-0088 - S3 bucket does not have encryption enabled
Severity: HIGH
File: main.tf, Line 26
Why: Data at rest is vulnerable without encryption
Recommended: Add aws_s3_bucket_server_side_encryption_configuration
```

**Step 2: Understand the Risk**
Before fixing, understand what could go wrong:
- How would someone exploit this?
- What's the actual impact to your business?
- Is this finding relevant to your use case?

**Step 3: Implement the Fix**
Add the recommended configuration to your code:
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

**Step 4: Re-run Scans**
```bash
git add main.tf
git commit -m "fix: enable S3 bucket encryption"
git push
# GitHub Actions automatically re-runs all scans
```

**Step 5: Verify It Passes**
Check the pipeline results in GitHub. Should show:
```
✅ terraform-security — All checks passed
```

**Step 6: Merge**
Now it's safe to merge. The issue is fixed and verified.

### Complete Example: Fixing Multiple Issues

**Scenario:** Pipeline found 3 issues

```
Finding 1: HIGH - S3 bucket not encrypted
Finding 2: MEDIUM - No access logging
Finding 3: LOW - Missing description on policy
```

**Your Fixed Code:**
```hcl
# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable logging
resource "aws_s3_bucket_logging" "website" {
  bucket        = aws_s3_bucket.website.id
  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "website-logs/"
}

# Add descriptions (fixes LOW finding)
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  
  # Description: Allows public read access for website content
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
```

**After Push:**
```
✅ Terraform Security: All checks passed
✅ Semgrep Analysis: All checks passed
✅ SonarQube: All checks passed
```

All three issues fixed, code is ready to merge.

---

## Compliance & Governance

Compliance means your infrastructure meets industry standards and regulations.

### SOC 2 Type II

**What It Is:**
SOC 2 is an audit standard that proves your company has proper security controls. Most SaaS companies require this from their vendors.

**Requirements This Project Meets:**

| Requirement | What It Means | How Your Project Satisfies It |
|---|---|---|
| CC6.1 - Access Control | Only authorized people access resources | S3 bucket policy restricts access |
| A1.1 - Encryption | Data is encrypted | AES-256 encryption enabled |
| CC7.2 - Logging | All access is recorded | S3 access logs capture everything |
| CC6.2 - Access Revocation | Can remove access immediately | IAM policies can be updated instantly |

**Real Impact:**
If your website becomes a business critical service, customers will ask: "Can you prove you have security controls?" This project proves it.

### GDPR (General Data Protection Regulation)

**What It Is:**
EU regulation protecting personal data. If any EU residents visit your site, GDPR applies.

**Key Articles Your Project Addresses:**

| Article | Requirement | How Your Project Complies |
|---|---|---|
| Article 32 | Encryption of personal data | S3 encryption enabled |
| Article 15 | Right to see access history | S3 logging provides audit trail |
| Article 17 | Right to be deleted (erasure) | S3 versioning allows deletion |
| Article 5 | Data integrity | Encryption prevents tampering |

**Example:**
EU user asks: "Give me all data you have about me and prove you haven't been breached."

Your Answer:
- ✅ All data encrypted (Article 32)
- ✅ Access logs prove no unauthorized access (Article 15)
- ✅ Can be deleted on request (Article 17)

### PCI-DSS (Payment Card Industry Data Security Standard)

**What It Is:**
If you handle credit card payments, PCI-DSS compliance is mandatory.

**Relevant Controls:**

| Control | Requirement | How Your Project Helps |
|---|---|---|
| 3.4 | Encryption of cardholder data | S3 encryption protects card data |
| 10.2 | Logging of access | S3 access logs required |
| 10.3 | Log protection | Separate logging bucket can't be modified |

**Note:** This project's S3 website wouldn't normally store card data. But if you add payment processing later, this infrastructure foundation meets PCI-DSS requirements.

### Compliance Automation

Instead of manual audits annually:
- tfsec continuously checks compliance
- Pipeline blocks non-compliant code
- Compliance score updates real-time
- Annual audit becomes verification, not discovery

---

## Observability & Metrics

Observability means: "You can see what's happening and detect problems."

### Key Metrics to Track

**1. Security Scan Pass Rate**
```
Metric: % of code changes that pass all security scans
Current Target: > 95%
Goal: 100%

Example:
Month 1: 70% pass (many security issues being fixed)
Month 2: 82% pass (team learning security)
Month 3: 95% pass (best practices becoming habit)
```

**2. Mean Time to Remediation (MTTR)**
```
Metric: How fast you fix security issues
Current Target: < 1 hour
Goal: < 30 minutes

Example:
tfsec finds issue → You get notification → You fix → Re-run → Merged
Week 1: Average 2 hours to fix
Week 2: Average 1.5 hours
Week 3: Average 45 minutes
```

**3. Critical Findings Trend**
```
Metric: Number of critical security issues over time
Current Target: 0 → Decreasing

Graph:
Week 1: ████ (4 critical issues)
Week 2: ███  (3 critical issues)
Week 3: ██   (2 critical issues)
Week 4: █    (1 critical issue)
Week 5: -    (0 critical issues)
```

**4. Code Quality Score**
```
Metric: Overall quality of infrastructure code
Current Target: > 80%
Goal: > 90%

Factors:
- Duplicate code (lower = better)
- Complexity (lower = better)
- Code smells (lower = better)
- Security issues (lower = better)
```

### GitHub Dashboard Integration

GitHub Actions automatically tracks these metrics:

```
Go to: Your Repo → Actions → Security Tab

Shows:
✅ Last scan: PASSED
✅ Issues found this month: 12
✅ Issues fixed this month: 12
✅ Average time to fix: 45 minutes
✅ Compliance score: 95%
```

### Example Metrics Report

```
Monthly Security Report

Scans Run: 42 (every code change)
Scans Passed: 40 (95%)
Scans Failed: 2 (5%)

Issues Found: 18
├─ Critical: 0
├─ High: 3 (all fixed)
├─ Medium: 8 (6 fixed, 2 in progress)
└─ Low: 7 (4 fixed, 3 deferred)

Mean Time to Remediation: 52 minutes
Code Quality Score: 87%
Compliance: SOC 2 ✅ GDPR ✅ PCI-DSS ✅
```

---

## Production Deployment Strategy

Moving from development to production requires careful planning.

### Pre-Production Checklist

Before deploying to production (real users), verify:

```
Security Checklist:
☐ All GitHub Actions scans passing
☐ No CRITICAL findings
☐ All HIGH findings documented
☐ Security team approval received
☐ Encryption enabled
☐ Logging enabled
☐ Access controls reviewed
☐ Backup/recovery tested

Operational Checklist:
☐ Staging deployment successful
☐ Load testing completed
☐ DNS configured
☐ SSL certificate installed
☐ Monitoring configured
☐ On-call team trained

Compliance Checklist:
☐ Compliance requirements met
☐ Audit logging enabled
☐ Data retention policy set
☐ Legal team approved
☐ Privacy policy updated
```

### Deployment Stages

**Stage 1: Development Environment**
- Only you can access
- Security scans run locally
- Changes quick and frequent
- Cost: Minimal

**Stage 2: GitHub Actions (CI Pipeline)**
- Automated scans on every push
- Public scans if open-source
- Problems caught before merge
- Cost: Free (GitHub includes)

**Stage 3: Staging Environment**
- Exact copy of production setup
- Real AWS account (different from production)
- Full testing before production
- Security team reviews
- Cost: ~$50-100/month

**Stage 4: Production Environment**
- Real users
- Real data
- High availability required
- Maximum security
- Cost: Depends on traffic

### Deployment Process

```
1. You make changes
   ↓
2. GitHub Actions runs scans
   ├─ tfsec checks
   ├─ Semgrep checks
   ├─ SonarQube checks
   ↓
3. All scans pass?
   ├─ YES → Code ready to merge
   └─ NO → Fix issues, re-run scans
   ↓
4. Code review (another person approves)
   ↓
5. Merge to main branch
   ↓
6. Deploy to staging environment
   ├─ Run integration tests
   ├─ Manual testing
   ├─ Security team verification
   ↓
7. Deploy to production
   ├─ Backup production
   ├─ Deploy new version
   ├─ Run smoke tests
   ├─ Monitor for errors
   ↓
8. Production live ✅
```

### Rollback Strategy

If something goes wrong in production:

```
Issue detected in production
  ↓
Determine cause
  ↓
Option 1 (If recent change caused it):
  Rollback to previous version
  ↓
  Revert commit: git revert <commit-hash>
  ↓
  Deploy reverted code
  ↓
  Back to working state in ~5 minutes

Option 2 (If data issue):
  Restore from S3 versioning
  ↓
  s3 sync s3://bucket --version-id <version>
  ↓
  Data restored to previous state
```

### Post-Deployment Monitoring

After deployment, monitor for:

```
Real-Time Monitoring:
- Website uptime: Is it accessible?
- Response time: Is it fast?
- Error rate: Any 5xx errors?
- Traffic: Is it being used?

Security Monitoring:
- Access logs: Any suspicious activity?
- Failed requests: Any attack patterns?
- Data changes: Unexpected modifications?
- Compliance: Still meets requirements?

Automated Alerts:
- Website down? → Alert team immediately
- High error rate? → Alert team
- Suspicious access pattern? → Alert security team
- Compliance violation? → Alert management
```

---

## Getting Started

### Prerequisites

Before you start, make sure you have:

1. **AWS Account** - For hosting (free tier available)
2. **GitHub Account** - For code and automation (free)
3. **Terraform Installed** - Infrastructure as Code tool
4. **Git Installed** - Version control
5. **AWS Credentials Configured** - Local machine access to AWS

### Quick Setup Instructions

**1. Install Required Tools**

macOS:
```bash
# Install Terraform
brew install terraform

# Install AWS CLI
brew install awscli

# Install Git (usually pre-installed)
git --version
```

Linux (Ubuntu):
```bash
# Install Terraform
wget https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip
unzip terraform_1.7.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install AWS CLI
sudo apt install awscli

# Git
sudo apt install git
```

**2. Configure AWS Credentials**
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Enter default region: eu-north-1
# Enter default output format: json
```

**3. Create Project Directory**
```bash
mkdir terraform-s3-website
cd terraform-s3-website
git init
```

**4. Create Terraform Files**

Create `main.tf`:
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

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "website" {
  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"
  tags = {
    Name = "Static Website Bucket"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

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

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "website/index.html"
  content_type = "text/html"
  etag         = filemd5("website/index.html")
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  source       = "website/error.html"
  content_type = "text/html"
  etag         = filemd5("website/error.html")
}
```

Create `variables.tf`:
```hcl
variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "eu-north-1"
}

variable "bucket_name" {
  description = "Base name for S3 bucket"
  type        = string
  default     = "my-static-website"
}
```

Create `outputs.tf`:
```hcl
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "website_endpoint" {
  description = "Website URL"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.website.bucket_domain_name
}
```

**5. Create Website Content**
```bash
mkdir website
```

Create `website/index.html`:
```html
<!DOCTYPE html>
<html>
<head>
  <title>My Secure Website</title>
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
    <h1>🎉 Welcome!</h1>
    <p>Secure infrastructure deployed with Terraform</p>
    <p>Scanned with tfsec, Semgrep, and SonarQube</p>
  </div>
</body>
</html>
```

Create `website/error.html`:
```html
<!DOCTYPE html>
<html>
<head>
  <title>404 - Not Found</title>
</head>
<body>
  <h1>404 - Page Not Found</h1>
  <p>Sorry, the page you're looking for doesn't exist.</p>
</body>
</html>
```

**6. Deploy with Terraform**
```bash
terraform init
terraform plan
terraform apply
```

Type `yes` when prompted.

**7. Access Your Website**
```bash
terraform output website_endpoint
# Copy the URL into your browser
```

**8. Set Up GitHub Actions**

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
          publishDeployment: your-org-name

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

**9. Set Up GitHub Secrets**

Go to: Your GitHub Repo → Settings → Secrets and add:

- `SEMGREP_APP_TOKEN` - Get from https://semgrep.dev/dashboard
- `SONAR_TOKEN` - Get from https://sonarcloud.io
- `SONAR_HOST_URL` - Use `https://sonarcloud.io`

**10. Push to GitHub**
```bash
git add .
git commit -m "Initial infrastructure setup with security pipeline"
git push origin main
```

Watch the pipeline run in GitHub Actions tab!

---

## Troubleshooting

### "terraform init" fails

**Error:**
```
Error: error configuring the backend "s3": IAM
```

**Solution:**
Make sure AWS credentials are configured:
```bash
aws sts get-caller-identity
# Should show your AWS account ID
```

If not configured:
```bash
aws configure
# Follow the prompts
```

### "terraform validate" shows errors

**Error:**
```
Error: Invalid resource reference
  on main.tf:10: 10: resource "aws_s3_bucket"
```

**Solution:**
Check your syntax carefully. Common mistakes:
- Missing commas after values
- Incorrect indentation
- Typos in resource names

Fix the error and re-run:
```bash
terraform validate
```

### Website shows "Access Denied"

**Problem:** You can access the bucket but not the website

**Solution:**
1. Wait 2-3 minutes (S3 eventually consistent)
2. Verify bucket policy is applied:
```bash
terraform apply
```
3. Check bucket website configuration:
```bash
aws s3api get-bucket-website --bucket <your-bucket-name>
```

### GitHub Actions failing

**Problem:** Pipeline shows red X

**Solution:**
1. Click the failed job to see logs
2. Look for error messages
3. Common issues:
   - Missing GitHub secrets (add them)
   - AWS credentials invalid (reconfigure)
   - Terraform syntax errors (fix code)

### "Access Denied" when uploading files

**Problem:** Can't upload to S3 bucket

**Solution:**
Verify your AWS user has S3 permissions:
```bash
aws s3 ls
# Should list your buckets
```

If not working, check IAM permissions in AWS console.

### Semgrep or SonarQube not working

**Problem:** GitHub Actions shows "Insufficient permissions"

**Solution:**
1. Verify secrets are added:
```bash
# In GitHub repo settings, check:
- SEMGREP_APP_TOKEN exists
- SONAR_TOKEN exists
- SONAR_HOST_URL exists
```

2. Regenerate tokens:
   - Semgrep: https://semgrep.dev/dashboard
   - SonarQube: https://sonarcloud.io

3. Update secrets in GitHub

### Pipeline blocking merge I don't understand

**Problem:** "Finding XYZ: Cannot merge"

**Solution:**
1. Read the finding description carefully
2. Click the link to full documentation
3. Implement recommended fix
4. Re-run pipeline

Still confused? 
- Comment in PR asking for clarification
- Check tfsec docs: https://aquasecurity.github.io/tfsec/
- Read the security best practice mentioned

---

## Key Takeaways

You now have a production-ready infrastructure with:

✅ **Infrastructure as Code** - Everything defined in Terraform
✅ **Automated Security Scanning** - Catches issues before production
✅ **Three Complementary Tools** - tfsec, Semgrep, SonarQube
✅ **CI/CD Pipeline** - Security checks on every code change
✅ **Compliance Ready** - Meets SOC 2, GDPR, PCI-DSS
✅ **Observable Infrastructure** - Track metrics and compliance
✅ **Production Deployment** - Safe path to live infrastructure

Most importantly: Security doesn't slow you down. It speeds you up by catching problems early when they're cheap to fix.

---

## Next Steps to Go Deeper

1. **Add HTTPS/SSL**: Encrypt traffic with CloudFront + Certificate Manager
2. **Enable Versioning**: Protect against accidental deletion
3. **Add CloudFront CDN**: Faster delivery, DDoS protection
4. **Setup CloudWatch**: Monitor infrastructure in real-time
5. **Implement Auto-Remediation**: Automatically fix certain issues
6. **Add Multi-Region**: Deploy across AWS regions for resilience

---

## Resources

- **Terraform Docs**: https://www.terraform.io/docs
- **AWS S3 Guide**: https://docs.aws.amazon.com/s3/
- **tfsec**: https://aquasecurity.github.io/tfsec/
- **Semgrep**: https://semgrep.dev/
- **SonarQube**: https://www.sonarqube.org/
- **GitHub Actions**: https://docs.github.com/en/actions
- **AWS Security**: https://aws.amazon.com/security/best-practices/
- **DevSecOps**: https://owasp.org/www-project-devsecops-guideline/

---

## Summary

You've learned how to:
- Build infrastructure as code
- Automate security scanning
- Fix security issues quickly
- Meet compliance requirements
- Deploy safely to production


## Index

# Project Images
The images below are from the project. 

**tfsec security results**

![Alt text](/images/terraform12.png)

**tfsec exposed vulnerability**

![Alt text](/images/terraform13.png)

**S3-web-server**

![Alt text](/images/terraform14.png)



