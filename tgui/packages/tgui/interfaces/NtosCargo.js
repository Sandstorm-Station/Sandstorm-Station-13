import { CargoContent } from './Cargo.js';
import { NtosWindow } from '../layouts';

export const NtosCargo = (props, context) => {
  return (
    <NtosWindow
      width={800}
      height={500}>
      <NtosWindow.Content overflow="auto">
        <CargoContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
