import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const PlayerPlaytimes = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    clients,
  } = data;
  return (
    <Window
      title="Player Playtimes"
      width={470}
      height={700}
      resizable>
      <Window.Content scrollable>

        <Section>
          <LabeledList>
            {clients.map(client => (
              <LabeledList.Item
                key={client.ckey}
                label={client.playtime_hours}>
                <Button
                  icon={client.observer ? "ghost" : ""}
                  content={client.name}
                  disabled={!client.ingame}
                  onClick={() => act('observe', {
                    ckey: client.ckey,
                  })} />
                {!!client.warning_valve && (
                  <Button
                    icon="bomb"
                    color="average"
                    tooltip="This player touched a Transfer Valve."
                  />
                )}
                {!!client.warning_chem && (
                  <Button
                    icon="flask"
                    color="average"
                    tooltip="This player used a Chem Dispenser."
                  />
                )}
                {!!client.warning_canister && (
                  <Button
                    icon="spray-can"
                    color="average"
                    tooltip="This player touched a gas canister."
                  />
                )}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>

      </Window.Content>
    </Window>
  );
};
