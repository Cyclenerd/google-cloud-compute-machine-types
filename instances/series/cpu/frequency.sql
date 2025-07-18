/* Intel */
/* https://cloud.google.com/compute/docs/cpu-platforms#intel_processors */

/* Intel Xeon E5 (Sandy Bridge) */
UPDATE instances SET cpuBaseClock  = '2.6', cpuTurboClock  = '3.2', cpuSingleMaxTurboClock = '3.6' WHERE availableCpuPlatform LIKE "%Sandy%" AND series LIKE "n1";

/* Intel Xeon E5 v2 (Ivy Bridge) */
UPDATE instances SET cpuBaseClock  = '2.5', cpuTurboClock  = '3.1', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Ivy%" AND series LIKE "n1";

/* Intel Xeon E5 v3 (Haswell) */
UPDATE instances SET cpuBaseClock  = '2.3', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.8' WHERE availableCpuPlatform LIKE "%Haswell%" AND series LIKE "n1";

/* Intel Xeon E5 (Broadwell E5) */
UPDATE instances SET cpuBaseClock  = '2.2', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.7' WHERE availableCpuPlatform LIKE "%Broadwell%" AND series LIKE "n1";
UPDATE instances SET cpuBaseClock  = '2.2', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.7' WHERE availableCpuPlatform LIKE "%Broadwell%" AND series LIKE "e2";

/* Intel Xeon E7 (Broadwell E7) */
UPDATE instances SET cpuBaseClock  = '2.2', cpuTurboClock  = '2.6', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Broadwell%" AND series LIKE "m1";

/* Intel Xeon Scalable Processor (Skylake) 1st Generation */
UPDATE instances SET cpuBaseClock  = '2.0', cpuTurboClock  = '2.7', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Skylake%" AND series LIKE "n1";
UPDATE instances SET cpuBaseClock  = '2.0', cpuTurboClock  = '2.7', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Skylake%" AND series LIKE "e2";
UPDATE instances SET cpuBaseClock  = '2.0', cpuTurboClock  = '2.7', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Skylake%" AND series LIKE "m1";

/* Intel Xeon Scalable Processor (Cascade Lake) 2nd Generation */
UPDATE instances SET cpuBaseClock  = '2.8', cpuTurboClock  = '3.4', cpuSingleMaxTurboClock = '3.9' WHERE availableCpuPlatform LIKE "%Cascade Lake%" AND series LIKE "n2";
UPDATE instances SET cpuBaseClock  = '3.1', cpuTurboClock  = '3.8', cpuSingleMaxTurboClock = '3.9' WHERE availableCpuPlatform LIKE "%Cascade Lake%" AND series LIKE "c2";
UPDATE instances SET cpuBaseClock  = '2.5', cpuTurboClock  = '3.4', cpuSingleMaxTurboClock = '4.0' WHERE availableCpuPlatform LIKE "%Cascade Lake%" AND series LIKE "m2";
UPDATE instances SET cpuBaseClock  = '2.2', cpuTurboClock  = '2.9', cpuSingleMaxTurboClock = '3.7' WHERE availableCpuPlatform LIKE "%Cascade Lake%" AND series LIKE "a2";
UPDATE instances SET cpuBaseClock  = '2.2', cpuTurboClock  = '2.9', cpuSingleMaxTurboClock = '3.7' WHERE availableCpuPlatform LIKE "%Cascade Lake%" AND series LIKE "g2";

/* Intel Xeon Scalable Processor (Ice Lake) 3rd Generation */
UPDATE instances SET cpuBaseClock  = '2.6', cpuTurboClock  = '3.4', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Ice Lake%" AND series LIKE "n2";
UPDATE instances SET cpuBaseClock  = '3.1', cpuTurboClock  = '3.8', cpuSingleMaxTurboClock = '3.9' WHERE availableCpuPlatform LIKE "%Ice Lake%" AND series LIKE "c2";
UPDATE instances SET cpuBaseClock  = '2.6', cpuTurboClock  = '3.4', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Ice Lake%" AND series LIKE "m3";

/* Intel Xeon Scalable Processor (Sapphire Rapids) 4rd Generation */
UPDATE instances SET cpuBaseClock  = '1.9', cpuTurboClock  = '3.0', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Sapphire Rapids%" AND series LIKE "a3";
UPDATE instances SET cpuBaseClock  = '1.9', cpuTurboClock  = '3.0', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Sapphire Rapids%" AND series LIKE "c3";
UPDATE instances SET cpuBaseClock  = '1.9', cpuTurboClock  = '3.0', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Sapphire Rapids%" AND series LIKE "h3";
UPDATE instances SET cpuBaseClock  = '1.9', cpuTurboClock  = '3.0', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Sapphire Rapids%" AND series LIKE "z3";

/* Intel Xeon Scalable Processor (Emerald Rapids) 5th Generation */
UPDATE instances SET cpuBaseClock  = '2.3', cpuTurboClock  = '3.1', cpuSingleMaxTurboClock = '4.0' WHERE availableCpuPlatform LIKE "%Emerald Rapids%" AND series LIKE "c4";
UPDATE instances SET cpuBaseClock  = '2.1', cpuTurboClock  = '2.9', cpuSingleMaxTurboClock = '4.0' WHERE availableCpuPlatform LIKE "%Emerald Rapids%" AND series LIKE "a4";
UPDATE instances SET cpuBaseClock  = '2.1', cpuTurboClock  = '2.9', cpuSingleMaxTurboClock = '4.0' WHERE availableCpuPlatform LIKE "%Emerald Rapids%" AND series LIKE "m4";
UPDATE instances SET cpuBaseClock  = '2.1', cpuTurboClock  = '2.9', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Emerald Rapids%" AND series LIKE "n4";

/* Intel Xeon Scalable Processor (Granite Rapids) 6th Generation */
UPDATE instances SET cpuBaseClock  = '2.8', cpuTurboClock  = '3.9', cpuSingleMaxTurboClock = '4.2' WHERE availableCpuPlatform LIKE "%Granite Rapids%" AND series LIKE "c4";

/* AMD */
/* https://cloud.google.com/compute/docs/cpu-platforms#amd_processors */

/* AMD EPYC Rome 2nd Generation */
UPDATE instances SET cpuBaseClock  = '2.25', cpuTurboClock  = '2.7', cpuSingleMaxTurboClock = '3.3' WHERE availableCpuPlatform LIKE "%Rome%";

/* AMD EPYC Milan 3rd Generation */
UPDATE instances SET cpuBaseClock  = '2.45', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.5' WHERE availableCpuPlatform LIKE "%Milan%";

/* AMD EPYC Genoa 4rd Generation */
UPDATE instances SET cpuBaseClock  = '2.6', cpuTurboClock  = '3.45', cpuSingleMaxTurboClock = '3.7' WHERE availableCpuPlatform LIKE "%Genoa%";

/* AMD EPYC Turin 5th Generation */
UPDATE instances SET cpuBaseClock  = '2.7', cpuTurboClock  = '3.5', cpuSingleMaxTurboClock = '4.1' WHERE availableCpuPlatform LIKE "%Turin%";


/* Arm */
/* https://cloud.google.com/compute/docs/cpu-platforms#arm_processors */

/* Ampere Altra Q64-30 */
/* https://amperecomputing.com/briefs/ampere-altra-family-product-brief */
UPDATE instances SET cpuBaseClock = '3.0', cpuTurboClock = '3.0', cpuSingleMaxTurboClock = '3.0' WHERE availableCpuPlatform LIKE "%Ampere Altra%";

/* Google Axion Processors */
/* https://gist.github.com/Cyclenerd/57ffee632dcb3d7e537fbcdc9779cb50 */
UPDATE instances SET cpuBaseClock = '3.0', cpuTurboClock = '3.0', cpuSingleMaxTurboClock = '3.0' WHERE availableCpuPlatform LIKE "%Google Axion%";
