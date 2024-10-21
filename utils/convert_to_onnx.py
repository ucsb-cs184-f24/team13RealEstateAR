'''
python3 convert_to_onnx.py ../configs/export_config.yaml
'''

import sys, os, torch, torch.onnx, logging
from typing import List, Dict

from alignment import H4ArgumentParser

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from configs.dataclasses import SNNArguments, ONNXExportArguments
from src.models.configuration_SNN import SNN

logger = logging.getLogger(__name__)

def main():
    logging.basicConfig(
        format="%(asctime)s - %(levelname)s - %(name)s - %(message)s", 
        datefmt="%Y-%m-%d %H:%M:%S", 
        handlers=[logging.StreamHandler(sys.stdout)], 
    )
    log_level = logging.INFO
    logger.setLevel(log_level)
    
    parser = H4ArgumentParser((SNNArguments, ONNXExportArguments))
    snn_args, export_args = parser.parse()
    logger.info(f"SNN parameters {snn_args}")
    logger.info(f"Export parameters {export_args}")
    
    model = SNN(snn_args)
    model_params = sum(p.numel() for p in model.parameters()) / 1_000_000
    logger.info(f"Model Parameters: {model_params:.2f}M")
    
    model.export_to_onnx(export_args)
    logger.info("Model successfully exported to ONNX")

if __name__ == "__main__":
    main()