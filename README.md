# cus_service_dw_portfolio
Återskapat datalager med SQL Server, ETL process, modellering och analys i Power BI.

I det här projektet använder jag dummy-data och återskapar ett datalager från mitt nuvarande jobb för att kunna visa upp i min portfölj.

---

Jag har utvecklat detta datalager med hjälp av SQL Server för att konsolidera kundtjänstdata för att kunna möjliggöra bättre rapportering och stötta beslutsfattande.

## Specifikationer.
- **Data källor**: Datakällan är från ett CRM och ett ERP system, som här i projektet representeras av dummy-data från  CSV-filer.
- **Data Kvalitet**: Tvätta och städa data före analys.
- **Integration**: Kombinera båda källorna till en mer användarvänlig datamodell utformad för Power BI.
- **Omfattning & Dokumentation**: Tillhandahåll tydlig dokumentation av datamodellen främst för att stödja andra analysteam, samt att öka förståelsen hos icketekniska användare.

---

Datalagret och analysen är gjord för att ge detaljerade insikter i:
- **Ärende-volym**: Totalt antal inkommande ärenden per kategori för att se vad som belastar supporten mest.
- **Lösningstid**: Tid från att ett ärende skapas till att status ändras till "stängt".
- **Eftersläpning**: Andelen ärenden som fortfarande har status "öppet" baserat på historiska datum.
- **Flaskhalsar**: Identifiering av vilka specifika kategorier, t.ex. tull eller faktura som blir liggande öppna längst.
