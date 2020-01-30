# Github action to build an mkdocs site and sync it to S3 :rocket:
This is a very simple action to make publishing a static [mkdocs](https://www.mkdocs.org/) site even easier.

## Usage
### `workflow.yml` example
To use this action within your own repository, place the following example in your `.github/workflows` directory.

```
name: DeployToS3

on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: thomasattree/mkdocs2S3@master
      with:
        args: --acl public-read --follow-symlinks --delete
      env:
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_REGION: 'eu-west-1'   # optional: defaults to us-east-1
        SOURCE_DIR: 'site'      # optional: defaults to entire repository
```

The s3 command uses the raw AWS CLI so any args supported within the CLI can be passed through in the with statement above. If you are going to use the above example verbatim, be warned `--delete` **permanently deletes** files in the S3 bucket that are **not** present in the latest version of your build.
The above example will build and deploy your site on any push to master. This means your public site in S3 should always be up to date with your Github repository mkdocs `docs` directory.

## Environment variables
The action requires at least `AWS_S3_BUCKET`, `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY`. Store these as Github secrets and not statically typed in your configuration.

| Key | Value | Required | Default |
| - | - | - | - |
| 'AWS_S3_BUCKET' | Name of your S3 bucket eg.`my-bucket` | Yes | N/A |
| 'AWS_ACCESS_KEY_ID' | Your AWS IAM access key. Store this as a Github secret | Yes | N/A |
| 'AWS_SECRET_ACCESS_KEY' | Your AWS IAM secret key. Store this as a Github secret | Yes | N/A |
| 'AWS_REGION' | The region of your S3 bucket eg. `us-west-2` | No | eu-west-1 (Dublin) |
| 'SOURCE_DIR' | The name of the directory you want to sync with S3. Mkdocs by default builds site files in a directory named `site` | No | `.` |

## License

This project is distributed under the [MIT license](LICENSE.md).
