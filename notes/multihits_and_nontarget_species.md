# Handling MultiHit OTUs and Non-target Species

During curation of the final species tables, certain OTUs flagged as MultipleHits (only for the vert01 marker in the Barque pipeline) were manually reassigned. Read counts for these OTUs were consolidated under the most abundant LULU-retained OTU with the same taxonomic assignment, mirroring the approach described by Ballini et al. (2024, Table S3). This ensured ambiguous OTUs with identical taxonomy did not inflate species counts. All MultiHit assignment decisions are listed below.

In addition, species not considered target fish taxa (e.g., mammals, birds, ambiguous assignments) were removed from the final tables before downstream analysis. The removed species for each pipeline are summarized in the table at the end of this file.

---

## MultiHit OTU Reassignment (Barque, vert01 marker only)

For each MultiHit OTU listed below, read counts were manually assigned to the specified LULU-retained OTU:

- `zMultiple_Hits_Cercopithecidae_unknown_unknown-otu-19-3741` : `unknown_unknown_unknown-otu-61-122` : `unknown_unknown_unknown-otu-95-26` → assigned to `Cercopithecidae_unknown_unknown-otu-19-3741`
- `zMultiple_Hits_Cottidae_Cottus_unknown-otu-123-10` : `Cottidae_Cottus_unknown-otu-8-91216` → assigned to `Cottidae_Cottus_unknown-otu-8-91216`
- `zMultiple_Hits_Cottidae_Cottus_unknown-otu-8-91216` : `Cottidae_Cottus_unknown-otu-89-35` → assigned to `Cottidae_Cottus_unknown-otu-8-91216`
- `zMultiple_Hits_Cyprinidae_Barbus_caninus-otu-41-340` : `Cyprinidae_Barbus_plebejus-otu-3-309819` → assigned to `Cyprinidae_Barbus_plebejus-otu-3-309819`
- `zMultiple_Hits_Cyprinidae_Barbus_meridionalis-otu-106-20` : `Cyprinidae_Barbus_meridionalis-otu-14-7905` : `Cyprinidae_Barbus_meridionalis-otu-31-994` : `Cyprinidae_Barbus_plebejus-otu-3-309819` → assigned to `Cyprinidae_Barbus_plebejus-otu-3-309819`
- `zMultiple_Hits_Cyprinidae_Barbus_meridionalis-otu-106-20` : `Cyprinidae_Barbus_meridionalis-otu-14-7905` : `Cyprinidae_Barbus_meridionalis-otu-31-994` : `Cyprinidae_Barbus_plebejus-otu-3-309819` : `Cyprinidae_Barbus_unknown-otu-56-135` → assigned to `Cyprinidae_Barbus_plebejus-otu-3-309819`
- `zMultiple_Hits_Cyprinidae_Barbus_meridionalis-otu-14-7905` : `Cyprinidae_Barbus_plebejus-otu-3-309819` → assigned to `Cyprinidae_Barbus_plebejus-otu-3-309819`
- `zMultiple_Hits_Hominidae_Homo_sapiens-otu-74-73` : `unknown_unknown_unknown-otu-1-516279` → removed
- `zMultiple_Hits_Leuciscidae_Phoxinus_unknown-otu-113-14` : `Leuciscidae_Phoxinus_unknown-otu-4-227374` → assigned to `Leuciscidae_Phoxinus_unknown-otu-4-227374`
- `zMultiple_Hits_Leuciscidae_Phoxinus_unknown-otu-4-227374` : `Leuciscidae_Phoxinus_unknown-otu-91-33` → assigned to `Leuciscidae_Phoxinus_unknown-otu-4-227374`
- `zMultiple_Hits_Leuciscidae_Rutilus_pigus-otu-59-127` : `Leuciscidae_Squalius_squalus-otu-5-152686` → assigned to `Leuciscidae_Squalius_squalus-otu-5-152686`
- `zMultiple_Hits_Leuciscidae_Squalius_squalus-otu-5-152686` : `unknown_unknown_unknown-otu-107-19` → assigned to `Leuciscidae_Squalius_squalus-otu-5-152686`

---

## Non-target Species Removed Prior to Downstream Analysis

The table below summarizes all non-target species that were removed from the final species tables output from microDecon. Species are listed in rows, and the columns indicate which pipeline(s) they were detected in and removed from.

| Species                                    | APSCALE Tele02 | APSCALE Vert01 | Barque Tele02 | Barque Vert01 | eDNA-Container Tele02 | eDNA-Container Vert01 |
|--------------------------------------------|:--------------:|:--------------:|:-------------:|:-------------:|:---------------------:|:---------------------:|
| Acipenser persicus                         |      X         |                |               |               |                       |                       |
| Acipenseridae_Acipenser_unknown            |                |                |      X        |               |                       |                       |
| Acipenseridae_unknown_unknown              |                |                |               |      X        |                       |                       |
| Achalinus spinalis                         |      X         |                |               |               |                       |                       |
| Anas zonorhyncha                           |      X         |                |               |               |                       |                       |
| Anatidae_unknown_unknown                   |                |                |      X        |      X        |                       |                       |
| Anguilla rostrata                          |      X         |      X         |               |               |                       |                       |
| Anguilla malgumora                         |                |      X         |               |               |                       |                       |
| Apodemus sylvaticus                        |      X         |                |      X        |               |      X                |                       |
| Ardea cinerea                              |      X         |                |      X        |               |      X                |                       |
| Ardeidae_Ardea_cinerea                     |                |                |      X        |               |                       |                       |
| Ardeidae_unknown_unknown                   |                |                |      X        |               |                       |                       |
| Australolacerta australis                  |      X         |                |               |               |                       |                       |
| Balaenoptera omurai                        |                |      X         |               |               |                       |                       |
| Bathophilus longipinnis/pawneei            |      X         |                |               |               |                       |                       |
| Bison bonasus                              |      X         |                |               |               |                       |                       |
| Bombina variegata                          |                |      X         |               |      X        |      X                |      X                |
| Bombinatoridae_Bombina_pachypus            |                |                |               |               |      X                |                       |
| Bombinatoridae_Bombina_variegata           |                |                |               |      X        |                       |      X                |
| Bos frontalis                              |                |      X         |               |               |                       |                       |
| Bovidae_unknown_unknown                    |                |                |      X        |      X        |                       |                       |
| Bovidae_Bos_unknown                        |                |                |               |      X        |                       |                       |
| Bovidae_Capra_unknown                      |                |                |               |      X        |                       |                       |
| Bovidae_Capra_hircus                       |                |                |               |               |                       |      X                |
| Bufonidae_Bufo_unknown                     |                |                |               |      X        |                       |                       |
| Bufonidae_Didynamipus_sjostedti            |                |                |               |               |      X                |                       |
| Bufo verrucosissimus                       |                |      X         |               |               |                       |                       |
| Canidae_Canis_lupus                        |                |                |      X        |               |      X                |                       |
| Canidae_Canis_unknown                      |                |                |               |      X        |                       |                       |
| Canidae_unknown_unknown                    |                |                |               |      X        |                       |                       |
| Canidae_Vulpes_rueppellii                  |                |                |               |               |                       |      X                |
| Canis lupus                                |      X         |      X         |      X        |      X        |      X                |                       |
| Canis rufus                                |                |      X         |               |               |                       |                       |
| Capra caucasica                            |                |      X         |               |               |                       |                       |
| Capreolus pygargus                         |                |      X         |               |               |                       |                       |
| Cephalopterus ornatus                      |      X         |                |               |               |                       |                       |
| Ceratoscopelus warmingii                   |      X         |                |               |               |                       |                       |
| Cervidae_Cervus_elaphus                    |      X         |      X         |      X        |      X        |      X                |      X                |
| Cervidae_unknown_unknown                   |                |                |               |      X        |                       |                       |
| Cervus elaphus                             |      X         |      X         |      X        |      X        |      X                |      X                |
| Chrysolophus pictus                        |      X         |                |               |               |                       |                       |
| Cinclus mexicanus/pallasii                 |                |      X         |               |               |                       |                       |
| Clamator levaillantii                      |      X         |                |               |               |                       |                       |
| Coilia mystus                              |      X         |                |               |               |                       |                       |
| Cottidae_unknown_unknown                   |                |                |      X        |      X        |                       |                       |
| Cottus beldingii                           |      X         |                |               |               |                       |                       |
| Cottus perplexus                           |      X         |                |               |               |                       |                       |
| Ctenotus pantherinus                       |      X         |                |               |               |                       |                       |
| Cyprinidae_unknown_unknown                 |                |                |               |      X        |                       |                       |
| Dawkinsia filamentosa                      |                |      X         |               |               |                       |                       |
| Didynamipus sjostedti                      |                |                |               |               |      X                |                       |
| Enhydris enhydris                          |      X         |                |               |               |                       |                       |
| Enneanectes altivelis                      |      X         |                |               |               |                       |                       |
| Etheostoma caeruleum                       |      X         |                |               |               |                       |                       |
| Felidae_Felis_unknown                      |                |                |               |      X        |                       |      X                |
| Felis silvestris                           |                |      X         |               |               |                       |                       |
| Fringillidae_unknown_unknown               |                |                |      X        |      X        |                       |                       |
| Fringillidae_Fringilla_unknown             |                |                |               |      X        |                       |                       |
| Fringilla teydea                           |                |      X         |               |               |                       |                       |
| Fringillidae_Calcarius_lapponicus          |                |                |               |               |      X                |                       |
| Fundulus catenatus                         |      X         |                |               |               |                       |                       |
| Gavia immer                                |      X         |                |               |               |                       |                       |
| Gigantactis gibbsi                         |      X         |                |               |               |                       |                       |
| Gliridae_Glis_glis                         |      X         |      X         |      X        |      X        |      X                |      X                |
| Glis glis                                  |      X         |      X         |      X        |      X        |      X                |      X                |
| Gorilla beringei                           |                |                |               |               |      X                |                       |
| Gymnotus carapo                            |      X         |                |               |               |                       |                       |
| Herklotsichthys quadrimaculatus            |      X         |                |               |               |                       |                       |
| Helarctos unknown                          |                |                |               |      X        |                       |                       |
| Hominidae_Homo_sapiens                     |      X         |      X         |      X        |      X        |      X                |      X                |
| Hominidae_Homo_unknown                     |                |                |      X        |      X        |                       |                       |
| Hominidae_unknown_unknown                  |                |                |      X        |      X        |                       |                       |
| Homo sapiens                               |      X         |      X         |      X        |      X        |      X                |      X                |
| Homatula pycnolepis                        |      X         |                |               |               |                       |                       |
| Ichthyophis biangularis                    |      X         |                |               |               |                       |                       |
| Ictonyx striatus                           |                |      X         |               |               |                       |                       |
| Kraemeria cunicularia                      |                |      X         |               |               |                       |                       |
| Laemonema sp.                              |      X         |                |               |               |                       |                       |
| Lethrinus atkinsoni                        |      X         |                |               |               |                       |                       |
| Leptobrachium abbotti                      |      X         |                |               |               |                       |                       |
| Leptotyphlops nigricans                    |      X         |                |               |               |                       |                       |
| Leuciscidae_Phoxinus_ujmonensis            |                |                |               |               |      X                |                       |
| Leuciscidae_Rutilus_unknown                |                |                |      X        |               |                       |                       |
| Leuciscidae_Telestes_unknown               |                |                |      X        |               |                       |                       |
| Leuciscidae_unknown_unknown                |                |                |      X        |               |                       |                       |
| Limnonectes heinrichi                      |                |      X         |               |               |                       |                       |
| Lophura bulweri                            |                |      X         |               |               |                       |                       |
| Megaleporinus elongatus                    |      X         |                |               |               |                       |                       |
| Megophrys feae                             |      X         |                |               |               |                       |                       |
| Merluccius bilinearis                      |      X         |                |               |               |                       |                       |
| Mitophis pyrites                           |      X         |                |               |               |                       |                       |
| Monognathus jesperseni                     |      X         |                |               |               |                       |                       |
| Mus musculus                               |      X         |      X         |      X        |      X        |      X                |      X                |
| Muridae_Apodemus_sylvaticus                |      X         |                |      X        |               |      X                |                       |
| Muridae_Mus_musculus                       |      X         |      X         |      X        |      X        |      X                |      X                |
| Muridae_Mus_unknown                        |                |                |               |      X        |                       |                       |
| Muridae_Rattus_rattus                      |      X         |      X         |      X        |      X        |      X                |                       |
| Muridae_Rattus_unknown                     |                |                |               |      X        |                       |                       |
| Myotis daubentonii                         |      X         |                |      X        |               |      X                |                       |
| Nannocharax parvus                         |      X         |                |               |               |                       |                       |
| Neenchelys buitendijki                     |      X         |                |               |               |                       |                       |
| Neomys anomalus                            |      X         |                |      X        |      X        |      X                |                       |
| Neomys fodiens                             |      X         |                |      X        |      X        |      X                |                       |
| Nilssonia nigricans                        |      X         |                |               |               |                       |                       |
| No match / NoMatch / unknown_unknown_unknown |      X         |      X         |      X        |      X        |                       |                       |
| Oncorhynchus gilae                         |                |      X         |               |               |                       |                       |
| Onychogalea unguifera                      |      X         |                |               |               |                       |                       |
| Ophichthus evermanni                       |      X         |                |               |               |                       |                       |
| Opsaridium peringueyi                      |      X         |                |               |               |                       |                       |
| Pan troglodytes                            |                |      X         |               |               |                       |                       |
| Phaethon aethereus                         |      X         |                |               |               |                       |                       |
| Phalacrocorax lucidus                      |                |      X         |               |      X        |                       |                       |
| Phalacrocoracidae_Phalacrocorax_unknown    |                |                |               |      X        |                       |                       |
| Phasianidae_unknown_unknown                |                |                |      X        |      X        |                       |                       |
| Phoxinus lumaireul/phoxinus                |      X         |                |               |               |                       |                       |
| Phoxinus ujmonensis (Leuciscidae)          |                |                |               |               |      X                |                       |
| Plestiodon lynxe                           |      X         |                |               |               |                       |                       |
| Plestiodon quadrilineatus                  |      X         |                |               |               |                       |                       |
| Plethodontidae_Speleomantes_strinatii      |                |                |               |      X        |                       |      X                |
| Pristurus rupestris                        |      X         |                |               |               |                       |                       |
| Prunella modularis                         |                |      X         |               |      X        |                       |                       |
| Prunellidae_Prunella_unknown               |                |                |               |      X        |                       |                       |
| Pseudobranchus axanthus                    |      X         |                |               |               |                       |                       |
| Pseudocheilinus tetrataenia                |      X         |                |               |               |                       |                       |
| Pseudophilautus popularis                  |                |      X         |               |               |                       |                       |
| Pseudoplesiops revellei                    |      X         |                |               |               |                       |                       |
| Pseudoscaphirhynchus hermanni              |                |      X         |               |               |                       |                       |
| Rallidae_Rallus_aquaticus                  |                |                |               |      X        |                       |      X                |
| Rallus aquaticus                           |                |      X         |               |      X        |                       |      X                |
| Rana dalmatina                             |                |      X         |               |               |                       |      X                |
| Rana italica                               |                |      X         |               |      X        |                       |      X                |
| Ranidae_Pelophylax_unknown                 |                |                |               |      X        |                       |      X                |
| Ranidae_Rana_italica                       |                |                |               |      X        |                       |      X                |
| Ranidae_Rana_unknown                       |                |                |               |      X        |                       |                       |
| Ranidae_Pelophylax_kurtmuelleri            |                |                |               |               |                       |      X                |
| Rattus rattus                              |      X         |      X         |      X        |      X        |      X                |      X                |
| Rattus tanezumi                            |                |      X         |               |               |                       |                       |
| Rhynchocyon petersi                        |                |      X         |               |               |                       |                       |
| Rutilus meidingeri/rutilus                 |      X         |                |      X        |               |                       |                       |
| Rutilus pigus                              |                |      X         |               |               |                       |                       |
| Salmo trutta                               |                |      X         |               |      X        |                       |                       |
| Salamandridae_Salamandrina_unknown         |                |                |               |      X        |                       |                       |
| Salamandrina perspicillata                 |                |      X         |               |               |                       |                       |
| Salmonidae_Salmo_unknown                   |                |                |               |      X        |                       |                       |
| Scorpaenodes albaiensis                    |      X         |                |               |               |                       |                       |
| Siganus fuscescens                         |      X         |                |               |               |                       |                       |
| Siagonodon septemstriatus                  |                |      X         |               |               |                       |                       |
| Soricidae_Neomys_anomalus                  |      X         |                |      X        |      X        |      X                |                       |
| Soricidae_Neomys_fodiens                   |      X         |                |      X        |      X        |      X                |                       |
| Soricidae_unknown_unknown                  |                |                |               |      X        |                       |                       |
| Speleomantes strinatii                     |                |      X         |               |      X        |                       |      X                |
| Spatula cyanoptera                         |                |      X         |               |               |                       |                       |
| Stichophanes ningshaanensis                |      X         |                |               |               |                       |                       |
| Suidae_Sus_scrofa                          |      X         |                |      X        |      X        |      X                |      X                |
| Sus scrofa                                 |      X         |                |      X        |      X        |      X                |      X                |
| Sylviidae_Sylvia_atricapilla               |                |                |               |      X        |                       |      X                |
| Sylvia atricapilla                         |                |      X         |               |      X        |                       |      X                |
| Thryonomys swinderianus                    |                |      X         |               |               |                       |                       |
| Thymallus arcticus                         |                |      X         |               |               |                       |                       |
| Trachipterus ishikawae                     |      X         |                |               |               |                       |                       |
| Trogon citreolus/melanocephalus            |      X         |                |               |               |                       |                       |
| Turdus lherminieri                         |                |      X         |               |               |                       |                       |
| Turdus philomelos                          |      X         |                |      X        |      X        |      X                |                       |
| Turdus poliocephalus                       |      X         |                |               |               |      X                |                       |
| Tylosurus melanotus                        |      X         |                |               |               |                       |                       |
| Ursidae_Ursus_arctos                       |                |                |               |               |      X                |                       |
| Ursidae_Ursus_unknown                      |      X         |      X         |      X        |      X        |                       |      X                |
| Ursidae_Helarctos_unknown                  |                |                |               |      X        |                       |                       |
| Ursus deningeri                            |                |      X         |               |               |                       |                       |
| Ursus maritimus                            |      X         |                |               |               |                       |                       |
| Ursus thibetanus                           |                |      X         |               |               |                       |                       |
| Vespertilionidae_Myotis_daubentonii        |      X         |                |      X        |               |      X                |                       |

*Note: "No match", "NoMatch", "unknown_unknown_unknown", and "sample" refer to ambiguous or unclassified species and have also been removed.*