import { NtosWindow } from '../layouts';
import { StationAlertConsoleContent } from './StationAlertConsole';

export const NtosStationAlertConsole = () => {
  return (
    <NtosWindow
      width={315}
      height={500}>
      <NtosWindow.Content overflow="auto">
        <StationAlertConsoleContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
