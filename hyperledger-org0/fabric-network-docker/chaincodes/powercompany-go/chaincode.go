package main

import (
	"fmt"
	"smartContract/global"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func main() {
	contract := new(global.Contract)
	contract.TransactionContextHandler = new(global.TransactionContext)
	contract.Name = "org.power_company.contract"
	contract.Info.Version = "0.0.1"

	chaincode, err := contractapi.NewChaincode(contract)

	if err != nil {
		panic(fmt.Sprintf("Error creating chaincode. %s", err.Error()))
	}

	chaincode.Info.Title = "PowerCompanyChaincode"
	chaincode.Info.Version = "0.0.1"

	err = chaincode.Start()

	if err != nil {
		panic(fmt.Sprintf("Error starting chaincode. %s", err.Error()))
	}
}
