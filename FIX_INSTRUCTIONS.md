# Build Failure Fix Instructions

## Problem
The build fails with error:
```
Localizable.xcstrings cannot co-exist with other .strings or .stringsdict tables with the same name.
```

## Root Cause
Xcode does not allow both the new `.xcstrings` format and legacy `.strings`/`.stringsdict` files with the same base name (e.g., "Localizable") to exist in the same target.

## Solution
Remove or rename the conflicting legacy localization files. Since the project has migrated to `.xcstrings` format, the legacy files should be removed.

### Files to Remove/Check:
1. Search for and remove: `CodeEdit/Localization/Localizable.strings`
2. Search for and remove: `CodeEdit/Localization/*/Localizable.strings` (in language-specific folders like `en.lproj`, `es.lproj`, etc.)
3. Search for and remove: `CodeEdit/Localization/Localizable.stringsdict`
4. Search for and remove: `CodeEdit/Localization/*/Localizable.stringsdict`

### Commands to Execute:
```bash
# Find all conflicting files
find . -name "Localizable.strings" -o -name "Localizable.stringsdict"

# Remove them (after verification)
find . -name "Localizable.strings" -delete
find . -name "Localizable.stringsdict" -delete
```

### Verification:
After removal, ensure only `Localizable.xcstrings` remains:
```bash
find . -name "Localizable.*" -type f
```

## Alternative Solution
If the legacy files are needed, rename `Localizable.xcstrings` to something else like `LocalizableNew.xcstrings`, but this is NOT recommended as it would break the localization system.
