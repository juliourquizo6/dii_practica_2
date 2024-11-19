from web3 import Web3
import requests

# Conexión al nodo de Sepolia
SEPOLIA_RPC_URL = "https://sepolia.infura.io/v3/e77f787cb45d48f7a9920ed9b7598e42"
web3 = Web3(Web3.HTTPProvider(SEPOLIA_RPC_URL))

def get_nft_metadata(contract_address, token_id, abi):
    if not web3.is_connected():
        raise Exception("No se pudo conectar a la red Sepolia")

    # Conectar al contrato.
    contract = web3.eth.contract(address=web3.to_checksum_address(contract_address), abi=abi)
    
    # Obtener el tokenURI del contrato.
    try:
        token_uri = contract.functions.tokenURI(token_id).call()
    except Exception as e:
        raise Exception(f"Error al obtener el tokenURI: {e}")
    
    # Descargar los metadatos desde el tokenURI.
    try:
        response = requests.get(token_uri)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        raise Exception(f"Error al obtener los metadatos: {e}")



