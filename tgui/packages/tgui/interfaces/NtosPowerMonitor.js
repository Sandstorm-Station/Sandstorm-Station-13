import { NtosWindow } from '../layouts';
import { PowerMonitorContent } from './PowerMonitor';

export const NtosPowerMonitor = () => {
  return (
    <NtosWindow
      width={550}
      height={700}>
      <NtosWindow.Content overflow="auto">
        <PowerMonitorContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
