#!/usr/bin/env bash
set -e

VERSION_OUTPUT=$(zksolc --version)
if [[ $VERSION_OUTPUT == *"1.4.1"* ]]; then
    JUMP_TABLE_FLAG="--jump-table-density-threshold 5"
else
    JUMP_TABLE_FLAG=
fi

preprocess -f era-contracts/system-contracts/contracts/EvmInterpreter.template.yul -d era-contracts/system-contracts/contracts/EvmInterpreterPreprocessed.yul
zksolc era-contracts/system-contracts/contracts/EvmInterpreterPreprocessed.yul --optimization 3 $JUMP_TABLE_FLAG --yul --bin --overwrite -o era-contracts/system-contracts/contracts-preprocessed/artifacts/

VERSION_OUTPUT=$(zksolc --version)
if [[ $VERSION_OUTPUT == *"1.5.1"* ]]; then
    mv -f era-contracts/system-contracts/contracts-preprocessed/artifacts/contracts/EvmInterpreterPreprocessed.yul.zbin era-contracts/system-contracts/contracts-preprocessed/artifacts/EvmInterpreterPreprocessed.yul.zbin
fi

VERSION_OUTPUT=$(zksolc --version)
if [[ $VERSION_OUTPUT == *"1.4.1"* ||  $VERSION_OUTPUT == *"1.5.1"* ]]; then
    python3 hex_to_binary.py
    mv -f bytecode era-contracts/system-contracts/contracts-preprocessed/artifacts/EvmInterpreterPreprocessed.yul.zbin
fi
