/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* https://launchpad.support.sap.com/#/notes/2456432 */

/* C2 */
/* Intel Cascade Lake */
UPDATE instances SET sap = '1', saps = '6040'  WHERE name LIKE 'c2-standard-4'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '12080' WHERE name LIKE 'c2-standard-8'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '24160' WHERE name LIKE 'c2-standard-16' AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '45300' WHERE name LIKE 'c2-standard-30' AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '90600' WHERE name LIKE 'c2-standard-60' AND availableCpuPlatform LIKE "%Cascade Lake%";

/* C3 */
/* Intel Sapphire Rapids */
UPDATE instances SET sap = '1' WHERE name LIKE 'c3-standard-%' AND availableCpuPlatform LIKE "%Sapphire Rapids%";
UPDATE instances SET sap = '1' WHERE name LIKE 'c3-highmem-%'  AND availableCpuPlatform LIKE "%Sapphire Rapids%";
/* TODO: Add SAPS from SAP note 2456432 */

/* C2D */
/* AMD EPYC Milan */
UPDATE instances SET sap = '1', saps = '3543'   WHERE name LIKE 'c2d-highmem-2'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '7086'   WHERE name LIKE 'c2d-highmem-4'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '14171'  WHERE name LIKE 'c2d-highmem-8'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '28343'  WHERE name LIKE 'c2d-highmem-16'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '56686'  WHERE name LIKE 'c2d-highmem-32'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '99200'  WHERE name LIKE 'c2d-highmem-56'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '190150' WHERE name LIKE 'c2d-highmem-112'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '3545'   WHERE name LIKE 'c2d-standard-2'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '7089'   WHERE name LIKE 'c2d-standard-4'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '14179'  WHERE name LIKE 'c2d-standard-8'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '28357'  WHERE name LIKE 'c2d-standard-16'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '56714'  WHERE name LIKE 'c2d-standard-32'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '99250'  WHERE name LIKE 'c2d-standard-56'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '189400' WHERE name LIKE 'c2d-standard-112' AND availableCpuPlatform LIKE "%Milan%";

/* N2 */
/* Intel Cascade Lake */
UPDATE instances SET sap = '1', saps = '2688'   WHERE name LIKE 'n2-highmem-2'    AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '5376'   WHERE name LIKE 'n2-highmem-4'    AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '10752'  WHERE name LIKE 'n2-highmem-8'    AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '21504'  WHERE name LIKE 'n2-highmem-16'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '43008'  WHERE name LIKE 'n2-highmem-32'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '64512'  WHERE name LIKE 'n2-highmem-48'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '86016'  WHERE name LIKE 'n2-highmem-64'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '107520' WHERE name LIKE 'n2-highmem-80'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '160080' WHERE name LIKE 'n2-highmem-96'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '183350' WHERE name LIKE 'n2-highmem-128'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '2632'   WHERE name LIKE 'n2-standard-2'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '5263'   WHERE name LIKE 'n2-standard-4'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '10525'  WHERE name LIKE 'n2-standard-8'   AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '21050'  WHERE name LIKE 'n2-standard-16'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '42100'  WHERE name LIKE 'n2-standard-32'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '63150'  WHERE name LIKE 'n2-standard-48'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '84200'  WHERE name LIKE 'n2-standard-64'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '105250' WHERE name LIKE 'n2-standard-80'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '159820' WHERE name LIKE 'n2-standard-96'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '183900' WHERE name LIKE 'n2-standard-128' AND availableCpuPlatform LIKE "%Cascade Lake%";
/* Intel Ice Lake */
UPDATE instances SET sap = '1', saps = '3574'   WHERE name LIKE 'n2-highmem-2'    AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '7148'   WHERE name LIKE 'n2-highmem-4'    AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '14296'  WHERE name LIKE 'n2-highmem-8'    AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '28593'  WHERE name LIKE 'n2-highmem-16'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '57185'  WHERE name LIKE 'n2-highmem-32'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '85778'  WHERE name LIKE 'n2-highmem-48'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '114370' WHERE name LIKE 'n2-highmem-64'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '133400' WHERE name LIKE 'n2-highmem-80'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '160080' WHERE name LIKE 'n2-highmem-96'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '183350' WHERE name LIKE 'n2-highmem-128'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '3576'   WHERE name LIKE 'n2-standard-2'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '7152'   WHERE name LIKE 'n2-standard-4'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '14304'  WHERE name LIKE 'n2-standard-8'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '28608'  WHERE name LIKE 'n2-standard-16'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '57215'  WHERE name LIKE 'n2-standard-32'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '85823'  WHERE name LIKE 'n2-standard-48'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '114430' WHERE name LIKE 'n2-standard-64'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '133183' WHERE name LIKE 'n2-standard-80'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '159820' WHERE name LIKE 'n2-standard-96'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '183900' WHERE name LIKE 'n2-standard-128' AND availableCpuPlatform LIKE "%Ice Lake%";

/* N2D */
/* AMD EPYC Rome */
UPDATE instances SET sap = '1', saps = '3111'   WHERE name LIKE 'n2d-highmem-2'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '6223'   WHERE name LIKE 'n2d-highmem-4'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '12445'  WHERE name LIKE 'n2d-highmem-8'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '24890'  WHERE name LIKE 'n2d-highmem-16'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '49780'  WHERE name LIKE 'n2d-highmem-32'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '74438'  WHERE name LIKE 'n2d-highmem-48'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '99250'  WHERE name LIKE 'n2d-highmem-64'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '115025' WHERE name LIKE 'n2d-highmem-80'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '138030' WHERE name LIKE 'n2d-highmem-96'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '3102'   WHERE name LIKE 'n2d-standard-2'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '6203'   WHERE name LIKE 'n2d-standard-4'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '12406'  WHERE name LIKE 'n2d-standard-8'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '24813'  WHERE name LIKE 'n2d-standard-16'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '49625'  WHERE name LIKE 'n2d-standard-32'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '74438'  WHERE name LIKE 'n2d-standard-48'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '99250'  WHERE name LIKE 'n2d-standard-64'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '115025' WHERE name LIKE 'n2d-standard-80'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '138030' WHERE name LIKE 'n2d-standard-96'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '177070' WHERE name LIKE 'n2d-standard-128' AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '229180' WHERE name LIKE 'n2d-standard-224' AND availableCpuPlatform LIKE "%Milan%";
/* AMD EPYC Milan */
UPDATE instances SET sap = '1', saps = '3160'   WHERE name LIKE 'n2d-highmem-2'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '6321'   WHERE name LIKE 'n2d-highmem-4'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '12641'  WHERE name LIKE 'n2d-highmem-8'    AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '25283'  WHERE name LIKE 'n2d-highmem-16'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '50565'  WHERE name LIKE 'n2d-highmem-32'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '75848'  WHERE name LIKE 'n2d-highmem-48'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '101130' WHERE name LIKE 'n2d-highmem-64'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '121108' WHERE name LIKE 'n2d-highmem-80'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '145330' WHERE name LIKE 'n2d-highmem-96'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '3166'   WHERE name LIKE 'n2d-standard-2'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '6333'   WHERE name LIKE 'n2d-standard-4'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '12665'  WHERE name LIKE 'n2d-standard-8'   AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '25330'  WHERE name LIKE 'n2d-standard-16'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '50660'  WHERE name LIKE 'n2d-standard-32'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '75990'  WHERE name LIKE 'n2d-standard-48'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '101320' WHERE name LIKE 'n2d-standard-64'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '120833' WHERE name LIKE 'n2d-standard-80'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '145000' WHERE name LIKE 'n2d-standard-96'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '185950' WHERE name LIKE 'n2d-standard-128' AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '272600' WHERE name LIKE 'n2d-standard-224' AND availableCpuPlatform LIKE "%Milan%";

/* T2D */
/* AMD EPYC Milan */
UPDATE instances SET sap = '1', saps = '4325'   WHERE name LIKE 't2d-standard-2'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '8650'   WHERE name LIKE 't2d-standard-4'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '17300'  WHERE name LIKE 't2d-standard-8'  AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '34600'  WHERE name LIKE 't2d-standard-16' AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '69200'  WHERE name LIKE 't2d-standard-32' AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '90064'  WHERE name LIKE 't2d-standard-48' AND availableCpuPlatform LIKE "%Milan%";
UPDATE instances SET sap = '1', saps = '112580' WHERE name LIKE 't2d-standard-60' AND availableCpuPlatform LIKE "%Milan%";

/* N1 */
/* Intel Broadwell or Intel Skylake */
UPDATE instances SET sap = '1', saps = '2090'   WHERE name LIKE 'n1-highmem-2'   AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '4180'   WHERE name LIKE 'n1-highmem-4'   AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '8360'   WHERE name LIKE 'n1-highmem-8'   AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '16720'  WHERE name LIKE 'n1-highmem-16'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '33440'  WHERE name LIKE 'n1-highmem-32'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '66880'  WHERE name LIKE 'n1-highmem-64'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '100320' WHERE name LIKE 'n1-highmem-96'  AND availableCpuPlatform LIKE "%Skylake%";
UPDATE instances SET sap = '1', saps = '8360'   WHERE name LIKE 'n1-standard-8'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '16720'  WHERE name LIKE 'n1-standard-16' AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '33440'  WHERE name LIKE 'n1-standard-32' AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '66880'  WHERE name LIKE 'n1-standard-64' AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '100320' WHERE name LIKE 'n1-standard-96' AND availableCpuPlatform LIKE "%Skylake%";

/* M2 */
/* Intel Cascade Lake */
UPDATE instances SET sap = '1', saps = '223325' WHERE name LIKE 'm2-ultramem-208' AND availableCpuPlatform LIKE "%Cascade Lake%";
/* Same core count. All with 416 cores. All with 446650 SAPS */
UPDATE instances SET sap = '1', saps = '446650' WHERE name LIKE 'm2-ultramem-416' AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '446650' WHERE name LIKE 'm2-megamem-416'  AND availableCpuPlatform LIKE "%Cascade Lake%";
UPDATE instances SET sap = '1', saps = '446650' WHERE name LIKE 'm2-hypermem-416' AND availableCpuPlatform LIKE "%Cascade Lake%";


/* M1 (Intel Broadwell or Intel Skylake) */
UPDATE instances SET sap = '1', saps = '105050' WHERE name LIKE 'm1-megamem-96'   AND availableCpuPlatform LIKE "%Skylake%";
UPDATE instances SET sap = '1', saps = '34475'  WHERE name LIKE 'm1-ultramem-40'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '68950'  WHERE name LIKE 'm1-ultramem-80'  AND availableCpuPlatform LIKE "%Broadwell%";
UPDATE instances SET sap = '1', saps = '137900' WHERE name LIKE 'm1-ultramem-160' AND availableCpuPlatform LIKE "%Broadwell%";

/* M3 */
/* Intel Ice Lake */
UPDATE instances SET sap = '1', saps = '47835'  WHERE name LIKE 'm3-ultramem-32'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '95670'  WHERE name LIKE 'm3-ultramem-64'  AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '184800' WHERE name LIKE 'm3-ultramem-128' AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '99170'  WHERE name LIKE 'm3-megamem-64'   AND availableCpuPlatform LIKE "%Ice Lake%";
UPDATE instances SET sap = '1', saps = '187620' WHERE name LIKE 'm3-megamem-128'  AND availableCpuPlatform LIKE "%Ice Lake%";