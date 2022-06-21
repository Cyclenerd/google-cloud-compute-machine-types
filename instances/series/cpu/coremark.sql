/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */


/* Intel Broadwell */
/* M1 */
UPDATE instances SET coremarkScore = '498947',  standardDeviation = '0.5',  sampleCount = '8431' WHERE name LIKE 'm1-ultramem-40';
UPDATE instances SET coremarkScore = '994301',  standardDeviation = '0.76', sampleCount = '4412' WHERE name LIKE 'm1-ultramem-80';
UPDATE instances SET coremarkScore = '1967211', standardDeviation = '0.59', sampleCount = '2092' WHERE name LIKE 'm1-ultramem-160';

/* Intel Skylake */
/* E2 */
UPDATE instances SET coremarkScore = '26973',   standardDeviation = '5.28',  sampleCount = '8784'  WHERE name LIKE 'e2-standard-2';
UPDATE instances SET coremarkScore = '55439',   standardDeviation = '4',     sampleCount = '8528'  WHERE name LIKE 'e2-standard-4';
UPDATE instances SET coremarkScore = '106182',  standardDeviation = '3.48',  sampleCount = '8268'  WHERE name LIKE 'e2-standard-8';
UPDATE instances SET coremarkScore = '222745',  standardDeviation = '1.9',   sampleCount = '6424'  WHERE name LIKE 'e2-standard-16';
UPDATE instances SET coremarkScore = '439445',  standardDeviation = '1.75',  sampleCount = '9304'  WHERE name LIKE 'e2-standard-32';
UPDATE instances SET coremarkScore = '26821',   standardDeviation = '4.7',   sampleCount = '8824'  WHERE name LIKE 'e2-highmem-2';
UPDATE instances SET coremarkScore = '55013',   standardDeviation = '3.79',  sampleCount = '8396'  WHERE name LIKE 'e2-highmem-4';
UPDATE instances SET coremarkScore = '106036',  standardDeviation = '4.46',  sampleCount = '8420'  WHERE name LIKE 'e2-highmem-8';
UPDATE instances SET coremarkScore = '221311',  standardDeviation = '2.5',   sampleCount = '6624'  WHERE name LIKE 'e2-highmem-16';
UPDATE instances SET coremarkScore = '26904',   standardDeviation = '4.13',  sampleCount = '8892'  WHERE name LIKE 'e2-highcpu-2';
UPDATE instances SET coremarkScore = '55441',   standardDeviation = '3.73',  sampleCount = '8460'  WHERE name LIKE 'e2-highcpu-4';
UPDATE instances SET coremarkScore = '106100',  standardDeviation = '3.31',  sampleCount = '8380'  WHERE name LIKE 'e2-highcpu-8';
UPDATE instances SET coremarkScore = '223077',  standardDeviation = '2.12',  sampleCount = '6452'  WHERE name LIKE 'e2-highcpu-16';
UPDATE instances SET coremarkScore = '438843',  standardDeviation = '1.95',  sampleCount = '9432'  WHERE name LIKE 'e2-highcpu-32';
UPDATE instances SET coremarkScore = '3333',    standardDeviation = '15.02', sampleCount = '8800'  WHERE name LIKE 'e2-micro';
UPDATE instances SET coremarkScore = '6700',    standardDeviation = '7.6',   sampleCount = '8920'  WHERE name LIKE 'e2-small';
UPDATE instances SET coremarkScore = '13663',   standardDeviation = '6.16',  sampleCount = '8832'  WHERE name LIKE 'e2-medium';
/* N1 */
UPDATE instances SET coremarkScore = '20090',   standardDeviation = '2.47',  sampleCount = '79672' WHERE name LIKE 'n1-standard-1';
UPDATE instances SET coremarkScore = '26532',   standardDeviation = '3.28',  sampleCount = '82204' WHERE name LIKE 'n1-standard-2';
UPDATE instances SET coremarkScore = '54678',   standardDeviation = '3.1',   sampleCount = '81744' WHERE name LIKE 'n1-standard-4';
UPDATE instances SET coremarkScore = '105383',  standardDeviation = '3.22',  sampleCount = '79268' WHERE name LIKE 'n1-standard-8';
UPDATE instances SET coremarkScore = '221834',  standardDeviation = '2.18',  sampleCount = '67668' WHERE name LIKE 'n1-standard-16';
UPDATE instances SET coremarkScore = '440755',  standardDeviation = '2.13',  sampleCount = '36300' WHERE name LIKE 'n1-standard-32';
UPDATE instances SET coremarkScore = '883369',  standardDeviation = '1.67',  sampleCount = '18568' WHERE name LIKE 'n1-standard-64';
UPDATE instances SET coremarkScore = '1247197', standardDeviation = '1.4',   sampleCount = '8772'  WHERE name LIKE 'n1-standard-96';
UPDATE instances SET coremarkScore = '26438',   standardDeviation = '2.87',  sampleCount = '85084' WHERE name LIKE 'n1-highmem-2';
UPDATE instances SET coremarkScore = '54337',   standardDeviation = '2.66',  sampleCount = '84532' WHERE name LIKE 'n1-highmem-4';
UPDATE instances SET coremarkScore = '104640',  standardDeviation = '2.79',  sampleCount = '82608' WHERE name LIKE 'n1-highmem-8';
UPDATE instances SET coremarkScore = '220547',  standardDeviation = '2.37',  sampleCount = '70820' WHERE name LIKE 'n1-highmem-16';
UPDATE instances SET coremarkScore = '439129',  standardDeviation = '2.45',  sampleCount = '38340' WHERE name LIKE 'n1-highmem-32';
UPDATE instances SET coremarkScore = '879708',  standardDeviation = '1.75',  sampleCount = '19732' WHERE name LIKE 'n1-highmem-64';
UPDATE instances SET coremarkScore = '1248277', standardDeviation = '1.3',   sampleCount = '9644'  WHERE name LIKE 'n1-highmem-96';
UPDATE instances SET coremarkScore = '26517',   standardDeviation = '2.8',   sampleCount = '84520' WHERE name LIKE 'n1-highcpu-2';
UPDATE instances SET coremarkScore = '54676',   standardDeviation = '2.81',  sampleCount = '84564' WHERE name LIKE 'n1-highcpu-4';
UPDATE instances SET coremarkScore = '105053',  standardDeviation = '2.59',  sampleCount = '84324' WHERE name LIKE 'n1-highcpu-8';
UPDATE instances SET coremarkScore = '221443',  standardDeviation = '2.1',   sampleCount = '72496' WHERE name LIKE 'n1-highcpu-16';
UPDATE instances SET coremarkScore = '438006',  standardDeviation = '2.17',  sampleCount = '38764' WHERE name LIKE 'n1-highcpu-32';
UPDATE instances SET coremarkScore = '874912',  standardDeviation = '1.64',  sampleCount = '19184' WHERE name LIKE 'n1-highcpu-64';
UPDATE instances SET coremarkScore = '1245251', standardDeviation = '1.46',  sampleCount = '9235'  WHERE name LIKE 'n1-highcpu-96';
UPDATE instances SET coremarkScore = '4111',    standardDeviation = '13.19', sampleCount = '82456' WHERE name LIKE 'f1-micro';
UPDATE instances SET coremarkScore = '10657',   standardDeviation = '12.09', sampleCount = '81152' WHERE name LIKE 'g1-small';
/* M1 */
UPDATE instances SET coremarkScore = '1254891', standardDeviation = '1.11',  sampleCount = '2852'  WHERE name LIKE 'm1-megamem-96';

/* Intel Cascade Lake */
/* C2 */
UPDATE instances SET coremarkScore = '77310',   standardDeviation = '1.15', sampleCount = '7035' WHERE name LIKE 'c2-standard-4';
UPDATE instances SET coremarkScore = '148689',  standardDeviation = '1.22', sampleCount = '4828' WHERE name LIKE 'c2-standard-8';
UPDATE instances SET coremarkScore = '313768',  standardDeviation = '1.32', sampleCount = '4292' WHERE name LIKE 'c2-standard-16';
UPDATE instances SET coremarkScore = '571147',  standardDeviation = '1.86', sampleCount = '2467' WHERE name LIKE 'c2-standard-30';
UPDATE instances SET coremarkScore = '1142234', standardDeviation = '1.51', sampleCount = '1535' WHERE name LIKE 'c2-standard-60';
/* N2 */
UPDATE instances SET coremarkScore = '69020',   standardDeviation = '0.83', sampleCount = '6131' WHERE name LIKE 'n2-standard-4';
UPDATE instances SET coremarkScore = '132589',  standardDeviation = '1.27', sampleCount = '6078' WHERE name LIKE 'n2-standard-8';
UPDATE instances SET coremarkScore = '279070',  standardDeviation = '1.19', sampleCount = '5410' WHERE name LIKE 'n2-standard-16';
UPDATE instances SET coremarkScore = '558589',  standardDeviation = '0.8',  sampleCount = '3028' WHERE name LIKE 'n2-standard-32';
UPDATE instances SET coremarkScore = '833947',  standardDeviation = '1.11', sampleCount = '2064' WHERE name LIKE 'n2-standard-48';
UPDATE instances SET coremarkScore = '1109876', standardDeviation = '1.11', sampleCount = '1568' WHERE name LIKE 'n2-standard-64';
UPDATE instances SET coremarkScore = '1288406', standardDeviation = '1.81', sampleCount = '1456' WHERE name LIKE 'n2-standard-80';
UPDATE instances SET coremarkScore = '33471',   standardDeviation = '0.68', sampleCount = '6069' WHERE name LIKE 'n2-highmem-2';
UPDATE instances SET coremarkScore = '68947',   standardDeviation = '1.02', sampleCount = '6102' WHERE name LIKE 'n2-highmem-4';
UPDATE instances SET coremarkScore = '132537',  standardDeviation = '1.08', sampleCount = '6124' WHERE name LIKE 'n2-highmem-8';
UPDATE instances SET coremarkScore = '278475',  standardDeviation = '1.17', sampleCount = '5411' WHERE name LIKE 'n2-highmem-16';
UPDATE instances SET coremarkScore = '558380',  standardDeviation = '0.87', sampleCount = '2996' WHERE name LIKE 'n2-highmem-32';
UPDATE instances SET coremarkScore = '831927',  standardDeviation = '1.45', sampleCount = '2077' WHERE name LIKE 'n2-highmem-48';
UPDATE instances SET coremarkScore = '1109925', standardDeviation = '1.09', sampleCount = '1566' WHERE name LIKE 'n2-highmem-64';
UPDATE instances SET coremarkScore = '1283110', standardDeviation = '1.85', sampleCount = '1480' WHERE name LIKE 'n2-highmem-80';
UPDATE instances SET coremarkScore = '33486',   standardDeviation = '0.52', sampleCount = '6061' WHERE name LIKE 'n2-highcpu-2';
UPDATE instances SET coremarkScore = '68980',   standardDeviation = '1.01', sampleCount = '6117' WHERE name LIKE 'n2-highcpu-4';
UPDATE instances SET coremarkScore = '132614',  standardDeviation = '0.96', sampleCount = '6037' WHERE name LIKE 'n2-highcpu-8';
UPDATE instances SET coremarkScore = '279395',  standardDeviation = '0.88', sampleCount = '5450' WHERE name LIKE 'n2-highcpu-16';
UPDATE instances SET coremarkScore = '558827',  standardDeviation = '0.9',  sampleCount = '2987' WHERE name LIKE 'n2-highcpu-32';
UPDATE instances SET coremarkScore = '835427',  standardDeviation = '1.16', sampleCount = '2057' WHERE name LIKE 'n2-highcpu-48';
UPDATE instances SET coremarkScore = '1110895', standardDeviation = '0.83', sampleCount = '1585' WHERE name LIKE 'n2-highcpu-64';
UPDATE instances SET coremarkScore = '1289988', standardDeviation = '1.8',  sampleCount = '1457' WHERE name LIKE 'n2-highcpu-80';

/* AMD EPYC Rome */
UPDATE instances SET coremarkScore = '34396',   standardDeviation = '1.35', sampleCount = '2696' WHERE name LIKE 'n2d-standard-2';
UPDATE instances SET coremarkScore = '71010',   standardDeviation = '1.71', sampleCount = '2704' WHERE name LIKE 'n2d-standard-4';
UPDATE instances SET coremarkScore = '134830',  standardDeviation = '1.07', sampleCount = '2688' WHERE name LIKE 'n2d-standard-8';
UPDATE instances SET coremarkScore = '279707',  standardDeviation = '1.78', sampleCount = '2288' WHERE name LIKE 'n2d-standard-16';
UPDATE instances SET coremarkScore = '563625',  standardDeviation = '2.12', sampleCount = '1288' WHERE name LIKE 'n2d-standard-32';
UPDATE instances SET coremarkScore = '843772',  standardDeviation = '2.67', sampleCount = '884'  WHERE name LIKE 'n2d-standard-48';
UPDATE instances SET coremarkScore = '1127574', standardDeviation = '1.14', sampleCount = '656'  WHERE name LIKE 'n2d-standard-64';
UPDATE instances SET coremarkScore = '1419027', standardDeviation = '1.39', sampleCount = '600'  WHERE name LIKE 'n2d-standard-80';
UPDATE instances SET coremarkScore = '1697951', standardDeviation = '1.48', sampleCount = '484'  WHERE name LIKE 'n2d-standard-96';
UPDATE instances SET coremarkScore = '2251019', standardDeviation = '1.54', sampleCount = '336'  WHERE name LIKE 'n2d-standard-128';
UPDATE instances SET coremarkScore = '3565048', standardDeviation = '2.8',  sampleCount = '200'  WHERE name LIKE 'n2d-standard-224';
UPDATE instances SET coremarkScore = '34300',   standardDeviation = '2.05', sampleCount = '2720' WHERE name LIKE 'n2d-highmem-2';
UPDATE instances SET coremarkScore = '70856',   standardDeviation = '2.36', sampleCount = '2692' WHERE name LIKE 'n2d-highmem-4';
UPDATE instances SET coremarkScore = '134588',  standardDeviation = '2.22', sampleCount = '2636' WHERE name LIKE 'n2d-highmem-8';
UPDATE instances SET coremarkScore = '279074',  standardDeviation = '2.29', sampleCount = '2308' WHERE name LIKE 'n2d-highmem-16';
UPDATE instances SET coremarkScore = '559560',  standardDeviation = '3.61', sampleCount = '1268' WHERE name LIKE 'n2d-highmem-32';
UPDATE instances SET coremarkScore = '838812',  standardDeviation = '3.73', sampleCount = '872'  WHERE name LIKE 'n2d-highmem-48';
UPDATE instances SET coremarkScore = '1119911', standardDeviation = '2.87', sampleCount = '660'  WHERE name LIKE 'n2d-highmem-64';
UPDATE instances SET coremarkScore = '1405243', standardDeviation = '2.92', sampleCount = '628'  WHERE name LIKE 'n2d-highmem-80';
UPDATE instances SET coremarkScore = '1674010', standardDeviation = '3.99', sampleCount = '472'  WHERE name LIKE 'n2d-highmem-96';
UPDATE instances SET coremarkScore = '34353',   standardDeviation = '1.01', sampleCount = '2716' WHERE name LIKE 'n2d-highcpu-2';
UPDATE instances SET coremarkScore = '71014',   standardDeviation = '1.44', sampleCount = '2692' WHERE name LIKE 'n2d-highcpu-4';
UPDATE instances SET coremarkScore = '134982',  standardDeviation = '0.77', sampleCount = '2636' WHERE name LIKE 'n2d-highcpu-8';
UPDATE instances SET coremarkScore = '279474',  standardDeviation = '1.19', sampleCount = '2312' WHERE name LIKE 'n2d-highcpu-16';
UPDATE instances SET coremarkScore = '564253',  standardDeviation = '1.78', sampleCount = '1272' WHERE name LIKE 'n2d-highcpu-32';
UPDATE instances SET coremarkScore = '845445',  standardDeviation = '1.73', sampleCount = '852'  WHERE name LIKE 'n2d-highcpu-48';
UPDATE instances SET coremarkScore = '1127676', standardDeviation = '1.2',  sampleCount = '648'  WHERE name LIKE 'n2d-highcpu-64';
UPDATE instances SET coremarkScore = '1416904', standardDeviation = '1.75', sampleCount = '596'  WHERE name LIKE 'n2d-highcpu-80';
UPDATE instances SET coremarkScore = '1690038', standardDeviation = '2.43', sampleCount = '468'  WHERE name LIKE 'n2d-highcpu-96';

/* AMD EPYC Milan */
UPDATE instances SET coremarkScore = '28961',   standardDeviation = '3.78', sampleCount = '1888' WHERE name LIKE 't2d-standard-1';
UPDATE instances SET coremarkScore = '58601',   standardDeviation = '3.64', sampleCount = '1888' WHERE name LIKE 't2d-standard-2';
UPDATE instances SET coremarkScore = '118761',  standardDeviation = '3.67', sampleCount = '1888' WHERE name LIKE 't2d-standard-4';
UPDATE instances SET coremarkScore = '229103',  standardDeviation = '3.78', sampleCount = '1876' WHERE name LIKE 't2d-standard-8';
UPDATE instances SET coremarkScore = '451682',  standardDeviation = '2.87', sampleCount = '1876' WHERE name LIKE 't2d-standard-16';
UPDATE instances SET coremarkScore = '886865',  standardDeviation = '1.69', sampleCount = '980'  WHERE name LIKE 't2d-standard-32';
UPDATE instances SET coremarkScore = '1305259', standardDeviation = '1.64', sampleCount = '672'  WHERE name LIKE 't2d-standard-48';
UPDATE instances SET coremarkScore = '1588850', standardDeviation = '1.2',  sampleCount = '672'  WHERE name LIKE 't2d-standard-60';