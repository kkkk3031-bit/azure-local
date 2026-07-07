#!/bin/bash
# Module practice: create resource group + storage accounts (AZ-400 Azure CLI unit)
# Usage: ./create-storage.sh [location] [count]
set -e

location=${1:-westus2}
count=${2:-1}

if ! az account show &> /dev/null; then
    echo "Error: not logged in. Run: az login --use-device-code"
    exit 1
fi

let "randomIdentifier=$RANDOM*$RANDOM"
resourceGroup="msdocs-rg-$randomIdentifier"

echo "Creating resource group $resourceGroup in $location..."
az group create --name "$resourceGroup" --location "$location" --output none
echo "✓ $resourceGroup"

for i in $(seq 1 "$count"); do
    saName=$(echo "msdocssa$(date +%s)$RANDOM" | cut -c1-24)
    echo "Creating storage account $saName..."
    az storage account create \
        --name "$saName" \
        --resource-group "$resourceGroup" \
        --location "$location" \
        --sku Standard_LRS \
        --kind StorageV2 \
        --tags Environment=Learning ManagedBy=AzureCLI \
        --output none
    echo "✓ $saName"
done

echo ""
az storage account list --resource-group "$resourceGroup" \
    --query "[].{Name:name, Location:location, SKU:sku.name}" --output table

echo ""
echo "Cleanup when done:  az group delete --name $resourceGroup --no-wait --yes"
