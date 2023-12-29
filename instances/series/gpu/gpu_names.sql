/* 
 * Replace graphics processing units (GPUs) type names
 * https://cloud.google.com/compute/docs/gpus#gpus-list
 */

UPDATE instances SET acceleratorType = "NVIDIA L4 vWS"     WHERE acceleratorType LIKE "nvidia-l4-vws";
UPDATE instances SET acceleratorType = "NVIDIA L4"         WHERE acceleratorType LIKE "nvidia-l4";

UPDATE instances SET acceleratorType = "NVIDIA A100 40GB"  WHERE acceleratorType LIKE "nvidia-tesla-a100";
UPDATE instances SET acceleratorType = "NVIDIA A100 80GB"  WHERE acceleratorType LIKE "nvidia-a100-80gb";

UPDATE instances SET acceleratorType = "NVIDIA T4 vWS"     WHERE acceleratorType LIKE "nvidia-tesla-t4-vws";
UPDATE instances SET acceleratorType = "NVIDIA T4"         WHERE acceleratorType LIKE "nvidia-tesla-t4";

UPDATE instances SET acceleratorType = "NVIDIA P4 vWS"     WHERE acceleratorType LIKE "nvidia-tesla-p4-vws";
UPDATE instances SET acceleratorType = "NVIDIA P4"         WHERE acceleratorType LIKE "nvidia-tesla-p4";

UPDATE instances SET acceleratorType = "NVIDIA V100"       WHERE acceleratorType LIKE "nvidia-tesla-v100";

UPDATE instances SET acceleratorType = "NVIDIA P100 vWS"   WHERE acceleratorType LIKE "nvidia-tesla-p100-vws";
UPDATE instances SET acceleratorType = "NVIDIA P100"       WHERE acceleratorType LIKE "nvidia-tesla-p100";

UPDATE instances SET acceleratorType = "NVIDIA H100 80GB"  WHERE acceleratorType LIKE "nvidia-h100-80gb";

UPDATE instances SET acceleratorType = "NVIDIA K80 (EOL!)" WHERE acceleratorType LIKE "nvidia-tesla-k80";
