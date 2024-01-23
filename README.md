## DynamoDB Package

This is a [Kurtosis Starlark Package](https://docs.kurtosis.com/quickstart) that allows you to spin up a DynamoDB instance with an admin UI.

### Run

This assumes you have the [Kurtosis CLI](https://docs.kurtosis.com/cli) installed

Simply run

```bash
kurtosis run github.com/kurtosis-tech/dynamodb-package
```

#### Configuration

<details>
    <summary>Click to see configuration</summary>

You can configure this package using a JSON structure as an argument to the `kurtosis run` function. The full structure that this package accepts is as follows, with default values shown (note that the `//` lines are not valid JSON and should be removed!):

```javascript
{
}
```

These arguments can either be provided manually:

```bash
kurtosis run github.com/kurtosis-tech/dynamodb-package '{}'
```

or by loading via a file, for instance using the [args.json](args.json) file in this repo:

```bash
kurtosis run github.com/kurtosis-tech/dynamodb-package --enclave dynamodb "$(cat args.json)"
```

</details>

### Using this in your own package

Kurtosis Packages can be used within other Kurtosis Packages, through what we call composition internally. Assuming you want to spin up dynamodb and your own service
together you just need to do the following

```py
main_dynamodb_module = import_module("github.com/kurtosis-tech/dynamodb-package/main.star")

# main.star of your dynamodb + Service package
def run(plan, args):
    plan.print("Spinning up the dynamodb Package")
    # this will spin up dynamodb and return the output of the dynamodb package
    dynamodb_run_output = main_dynamodb_module.run(plan, args)
```
