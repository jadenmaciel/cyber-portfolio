# AWS Cloud Guardrails – CIS-Lite Baseline (Student Project)

# Implementation Summary (Day 1)
Identity & Access
- Enabled MFA for IAM user used for administration.
- Verified root account hygiene: MFA enabled; no active root access keys.
- Granted temporary AdministratorAccess to the lab IAM user (for setup only).

# CloudTrail (Account-wide Logging)
- Created multi-region trail: org-trail.
- Storage: new S3 bucket cloudtrail-logs-<account-id>-us-east-1-<suffix> with public access block ON and SSE-KMS encryption.
- Enabled log file validation.
- Events: Management events = All; Data events = S3 object-level logging.
- Outcome: Trail status Logging = ON; multi-region = Yes.

# AWS Config (Change Tracking)
- Region of recorder: us-east-2.
- Storage: new S3 bucket awsconfig-<account-id>-us-east-2-<suffix> (same region as recorder).
- Added S3 bucket policy to allow config.amazonaws.com to GetBucketAcl and PutObject to AWSLogs/<account-id>/Config/* with bucket-owner-full-control.
- Recorder settings: Record all supported resource types; continuous recording.
- IAM: Confirmed/created service-linked role AWSServiceRoleForConfig.
- Outcome: Config started recording; configuration items observed in dashboard metrics.

# Buckets Created
- cloudtrail-logs-<account-id>-us-east-1-<suffix> (CloudTrail logs).
- awsconfig-<account-id>-us-east-2-<suffix> (AWS Config snapshots/change history).

# Evidence Artifacts (added to /evidence)
- iam-mfa-enabled.png
- root-keys-none.png
- cloudtrail-multiregion.png
- config-enabled.png
- config-enabled-2.png

# SCP Policy Intent (saved to /scp/)
deny-root-actions.json — Deny most actions when principal is root (except MFA-related and list/get).
deny-public-s3.json — Prevent disabling S3 account/bucket public-access blocks.

# Implementation Summary (Day 2) — Quick Wins & Visibility

## What changed

* Enabled three AWS Config managed rules:

  * `cloudtrail-enabled`

  * `s3-bucket-public-read-prohibited`

  * `iam-password-policy`

* Remediated **iam-password-policy** to compliant:

  * Min length 14; require upper/lower/number/symbol; prevent reuse (24); optional 90-day expiry if desired.

* Captured a compliance snapshot via **Advanced queries** using the `AWS::Config::ResourceCompliance` dataset.

* Verified CloudTrail log file validation (control check) and S3 **account-level** Public Access Block (from Day 1) remain enforced.

* Security Hub activation is pending account verification; Config rules and queries provide interim visibility.

## Evidence added (`/evidence/`)

* `config-rules-enabled.png` — list view showing the three rules enabled.

* `config-rule-cloudtrail-enabled.png` — rule details showing Compliant and last evaluation time.

* `config-rule-iam-password-policy.png` — rule details showing Compliant (after remediation).

* `config-rule-s3-public-read-prohibited.png` — rule details showing Compliant.

* `config-compliance-day1.csv` — counts by compliance type (Advanced queries export).

* *(optional)* `config-resource-compliance-list.csv` — per-resource compliance snapshot (Advanced queries export).

* *(from Day 1 controls check)* `s3-account-public-access-block.png`, `cloudtrail-log-file-validation.png`.

## Queries used (Advanced queries → Export as CSV)

```sql
-- Count by compliance (used for config-compliance-day1.csv)
SELECT
  configuration.complianceType,
  COUNT(*)
WHERE
  resourceType = 'AWS::Config::ResourceCompliance'
GROUP BY
  configuration.complianceType;
```

```sql
-- Optional: per-resource snapshot (used for config-resource-compliance-list.csv)
SELECT
  accountId,
  awsRegion,
  resourceId,
  resourceType,
  configuration.complianceType
WHERE
  resourceType = 'AWS::Config::ResourceCompliance'
ORDER BY
  configuration.complianceType, resourceType, resourceId;
```

## Findings (triage — 5 items)

| Finding / Control                          | Why it matters                                           | Action / Status                                                          |
| ------------------------------------------ | -------------------------------------------------------- | ------------------------------------------------------------------------ |
| IAM password policy weak or unset          | Weak console passwords increase credential-stuffing risk | Set length 14; complexity on; reuse 24 → **Compliant**                   |
| CloudTrail trail not enforced in region    | Gaps in audit trail hinder incident investigations       | Enabled multi-region trail; log file validation on → **Compliant**       |
| S3 public read not blocked at bucket level | Accidental data exposure via ACLs/policies               | Enabled rule; verified account-level Public Access Block → **Compliant** |
| Change-tracking visibility limited         | Hard to prove configuration history during reviews       | AWS Config recording across all resources; evidence CSV exported         |
| Missing centralized findings view          | Hard to prioritize remediation without a feed            | Security Hub enablement pending account activation (planned next)        |

## Results

* All three Config rules evaluate **Compliant**.

* Compliance export created for audit (`/evidence/config-compliance-day1.csv`).

* Controls sustained: CloudTrail validation and S3 account public access block.

## What's next (Day 3 or when Security Hub activates)

* Enable **Security Hub** (CIS + AWS Foundational standards) in `us-east-2`.

* Export findings CSV and update the Day 2 table with 5 concrete findings from Security Hub.

* Optional: enable **GuardDuty** and add a budget alarm for cost guardrails.

Awaiting Security Hub Verification