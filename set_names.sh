#!/bin/bash
if [ $# -ne 1 ]; then
    echo "This script sets up the resource names as constants for subsequent scripts to use."
    echo "The suffix used in the setup must be passed in."
    exit 1
fi
org_id=$1
org_id_lowercase=${org_id,,}

export OLA_RESOURCE_GROUP="rg-oea-${org_id}"
export OLA_BUDGET="budget-oea-${org_id}"

export OLA_DATA_FACTORY="adf-oea-${org_id_lowercase}"

export OLA_SYNAPSE="syn-oea-${org_id_lowercase}"
export OLA_STORAGE_ACCOUNT="stoea${org_id_lowercase}"

export OLA_ML_WORKSPACE="mlw-oea-${org_id_lowercase}"
export OLA_KEYVAULT="kv-oea-${org_id_lowercase}"
export OLA_ML_STORAGE_ACCOUNT="stmloea${org_id_lowercase}"
export OLA_APP_INSIGHTS="appi-oea-${org_id_lowercase}"

