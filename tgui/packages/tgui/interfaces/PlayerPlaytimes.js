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

                {client.flags.map(flag => (
                  <Button
                    key={flag.icon}
                    icon={flag.icon}
                    color="average"
                    tooltip={flag.tooltip}
                  />
                ))}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>

      </Window.Content>
    </Window>
  );
};
