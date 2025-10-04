# Branch Protection Setup Guide

This guide helps you configure branch protection rules on GitHub to keep the `main` branch stable and secure.

---

## 🎯 Why Branch Protection?

Branch protection prevents:
- ❌ Accidental force-pushes (rewriting history)
- ❌ Direct commits bypassing review
- ❌ Merging broken code (failing CI)
- ❌ Accidental branch deletion

For v1.0.0 and beyond, protecting `main` ensures stability for users installing from the repository.

---

## 📋 Recommended Protection Rules

### Minimum (Solo Maintainer)

1. **Protect against force pushes** ✅
2. **Protect against deletions** ✅
3. **Require status checks to pass** ✅ (once CI is working)

### Enhanced (Multiple Contributors)

Everything above, plus:
4. **Require pull request reviews** (at least 1 approval)
5. **Dismiss stale reviews** when new commits are pushed
6. **Require review from code owners** (optional)

---

## 🔧 Setup Instructions

### Step 1: Navigate to Branch Protection Settings

1. Go to your repository on GitHub
2. Click **Settings** (top navigation)
3. In the left sidebar, click **Branches**
4. Under "Branch protection rules", click **Add branch protection rule**

### Step 2: Configure the Rule

**Branch name pattern:**
```
main
```

**Enable these settings:**

#### ✅ Protect matching branches (Required)

- [x] **Require a pull request before merging**
  - _Optional for solo maintainer, recommended if you have contributors_
  - If enabled, you can set:
    - Required approvals: `1` (or more for teams)
    - [ ] Dismiss stale pull request approvals when new commits are pushed (optional)
    - [ ] Require review from Code Owners (if you have a CODEOWNERS file)

- [x] **Require status checks to pass before merging** ⭐
  - Click "Add" button and search for: `Test Installer` (or whatever your GitHub Action is named)
  - This ensures all CI tests pass before merging
  - [x] Require branches to be up to date before merging (recommended)

- [ ] **Require conversation resolution before merging**
  - Optional: Forces all PR comments to be resolved

- [x] **Require signed commits** 
  - Optional but recommended for security (requires GPG setup)

- [x] **Require linear history**
  - Optional: Prevents merge commits, cleaner history

- [ ] **Require deployments to succeed before merging**
  - Skip this unless you have deployment workflows

#### ✅ Rules applied to administrators

- [x] **Include administrators**
  - _Recommended:_ Even you (the admin) follow the rules
  - Prevents accidental mistakes

#### ✅ Restrict who can push to matching branches

- [ ] Leave unchecked for solo maintainer
- [x] Check if you want to limit who can push (for teams)

#### ✅ Allow force pushes

- [ ] **Leave UNCHECKED** ⚠️
  - Disallowing force pushes protects history

#### ✅ Allow deletions

- [ ] **Leave UNCHECKED** ⚠️
  - Prevents accidental deletion of `main` branch

### Step 3: Save

Click **Create** (or **Save changes** if editing existing rule)

---

## 🧪 Testing Branch Protection

### Test 1: Try Force-Pushing (Should Fail)

```bash
# This should be blocked
git push --force origin main
```

**Expected:** 
```
remote: error: GH006: Protected branch update failed
```

✅ **Good!** Branch protection is working.

### Test 2: Push to Main with Failing CI (Should Fail)

If you have "Require status checks" enabled:

1. Make a change that breaks the installer
2. Push to `main` (or PR to `main`)
3. CI should fail
4. Merge should be blocked until CI passes

✅ **Good!** CI protection is working.

### Test 3: Normal PR Workflow (Should Work)

```bash
# Create feature branch
git checkout -b feature/test-protection
echo "# Test" >> test.txt
git add test.txt
git commit -m "test: Verify branch protection"
git push origin feature/test-protection

# On GitHub: Create PR from feature/test-protection → main
# CI runs automatically
# Once CI passes, merge the PR
```

✅ **Good!** Normal workflow works as expected.

---

## 📸 Screenshot Reference

**Your settings should look like this:**

```
Branch name pattern: main

[x] Require a pull request before merging
    Required approvals: 1
    
[x] Require status checks to pass before merging
    Status checks that are required:
      ✓ Test Installer
    [x] Require branches to be up to date before merging

[x] Include administrators

[ ] Allow force pushes (UNCHECKED)
[ ] Allow deletions (UNCHECKED)
```

---

## 🚨 Emergency: Bypassing Protection

**If you absolutely need to bypass protection** (emergency fixes):

1. Temporarily disable the rule:
   - Settings → Branches → Edit rule
   - Uncheck protections
   - Save
2. Make your emergency push
3. **RE-ENABLE protection immediately**

**Better approach:** Use an emergency PR with immediate merge.

---

## 🔄 Updating Rules Later

You can adjust rules anytime:
1. Settings → Branches
2. Click "Edit" on the `main` rule
3. Modify settings
4. Save changes

**Common adjustments:**
- Add/remove required status checks
- Change required approval count
- Add more branches (e.g., protect `v1.0.x` release branch)

---

## 📚 Additional Resources

- [GitHub Docs: About protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [GitHub Docs: Managing a branch protection rule](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule)

---

## ✅ Verification Checklist

After setup, verify:

- [ ] Force-push to `main` is blocked
- [ ] Direct commit to `main` is blocked (if PR required)
- [ ] Can still create feature branches and PRs
- [ ] CI runs on PRs automatically
- [ ] Can merge PRs after CI passes
- [ ] Cannot delete `main` branch

**Once all checked:** Your branch is protected! 🔒

---

## 🎯 Summary

**Minimum protection (right now):**
```
✅ Block force pushes
✅ Block deletions
✅ Require CI to pass (Test Installer workflow)
```

**This gives you:**
- Stable `main` branch
- Automated testing before merge
- Safety against accidents
- Confidence in v1.0.0+ releases

**You can always add more rules later as the project grows!**
