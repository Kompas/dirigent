## Taak wegen — klein of groot

Weeg elke nieuwe taak voordat je begint en zeg in één regel wat je doet:

- **Klein** (past in één sessie, geen onafhankelijke delen): `Klein: doe ik zelf.` en doe het.
- **Groot** (past niet in één sessie, óf drie of meer onafhankelijke delen (delen die verschillende werkers tegelijk kunnen bouwen), óf raakt meerdere subsystemen of repos, óf een ontwerpkeuze met meerdere serieuze routes): `Groot: Fable maakt het plan, werkers bouwen, Fable controleert.`, laad dan de skill `dirigent` (als plugin: `dirigent:dirigent`) en volg die.

Een vraag, een meting, een opzoekactie of één bugfix is klein, ook als het onderwerp ingewikkeld is. Twijfel = klein; loopt het uit, schakel dan alsnog over en zeg dat.

Vervolgberichten: een antwoord, bijsturing of aanvulling op de lopende taak weeg je niet opnieuw en krijgt geen weegregel; je gaat door in dezelfde stand (binnen een dirigent-run verwerk je het in het plan). Weeg wel opnieuw bij een nieuwe taak in dezelfde sessie, en bij een faseovergang van de lopende taak: is het voorstel of onderzoek af en begint nu het ontwerpen of bouwen, weeg dan dat vervolg als een nieuwe taak.

De gebruiker draait de weging om met één woord: "klein", "groot" of "fable" (= dit deel door een Fable-subagent). Na een gekozen `/ambition`-upgrade is de uitvoering groot.

### Modelkeuze voor subagents

- Zoeken, bestanden opsommen, logs lezen: haiku. Helder en afgebakend: sonnet. Standaard: opus.
- Fable als subagent voor: het plan van een grote taak, de eindreview in een verse context, en een deel waar Opus twee keer op zijn toets faalde.
- Een subagent kost een volle eigen context. Start er een voor werk dat parallel loopt of je context zou vullen; een handvol tool-calls doe je zelf.
