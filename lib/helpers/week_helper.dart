String weekday(int weekday, {bool short = false}) {
  const fullNames = {
    1: 'Poniedziałek',
    2: 'Wtorek',
    3: 'Środa',
    4: 'Czwartek',
    5: 'Piątek',
    6: 'Sobota',
    7: 'Niedziela',
  };

  const shortNames = {
    1: 'Pon',
    2: 'Wt',
    3: 'Śr',
    4: 'Czw',
    5: 'Pt',
    6: 'Sob',
    7: 'Nd',
  };

  return short ? shortNames[weekday] ?? '-' : fullNames[weekday] ?? '-';
}
