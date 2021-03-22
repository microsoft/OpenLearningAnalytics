#!/bin/bash

# Sets up Clever module
if [ $# -ne 1 ]; then
    echo "This setup script will install this module into an existing Open Learning Analytics instance."
    echo "Invoke this script like this:"
    echo "    setup.sh <mysuffix>"
    echo "where mysuffix is the unique suffix used for your organization (eg, contosoisd)"
    exit 1
fi

org_id=$1
this_file_path=$(dirname $(realpath $0))
echo "--> Installing: $this_file_path, in resource group: $OLA_RESOURCE_GROUP"
source $this_file_path/../../set_names.sh $org_id

# copy test data set
source="$this_file_path/test-data/*"
destination="https://$OLA_STORAGE_ACCOUNT.blob.core.windows.net/test-env/stage1"
echo "--> Copying test data set from: $source  to: $destination"
storage_account_key=$(az storage account keys list -g $OLA_RESOURCE_GROUP -n $OLA_STORAGE_ACCOUNT --query [0].value -o tsv)
az storage copy --account-key $storage_account_key -s $source -d $destination --recursive

# Update the notebook to refer to the correct storage account
sed "s/storage_account = '.*'/storage_account = '$OLA_STORAGE_ACCOUNT'/" $this_file_path/notebooks/Clever_setup_and_update.ipynb > $this_file_path/../../tmp/Clever_setup_and_update.ipynb
# todo: import the notebook