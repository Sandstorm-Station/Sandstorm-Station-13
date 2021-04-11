import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Box, Blink, Button, Flex, LabeledList, Section, NumberInput } from '../components';
import { Window } from '../layouts';

export const Telesci = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    telepad,
    inserted_gps,
    temp_msg,
    rotation,
    angle,
    z_coord,
    last_tele_data,
    power_possible,
  } = data;
  return (
    <Window
      width={360}
      height={620}>
      <Window.Content>
        <Section>
          {!telepad && (
            <Box color="bad" backgroundColor="black">
              No telepad located.<br />
              Please add telepad data.<Blink>▍</Blink>
            </Box>
          ) || (
            <Section>
                <Button
                  content="Eject GPS"
                  disabled={!inserted_gps}
                  onClick={() => act('eject_gps')} />
                <Box color="green" backgroundColor="black">
                  {temp_msg.map(message => (
                    <div>
                    {message}
                    </div>
                  ))}
                </Box>
                <Section title="Set Bearing">
                <NumberInput
                    key="rotationValue"
                    width="65px"
                    unit="°"
                    value={rotation}
                    step={1}
                    stepPixelSize={25}
                    minValue={-900}
                    maxValue={900}
                    onDrag={(e, value) => act('setRotation', {
                      ref: value,
                    })} />
                </Section>
                <Section title="Set Elevation">
                <NumberInput
                      key="angleValue"
                      width="65px"
                      unit="°"
                      value={angle}
                      step={1}
                      stepPixelSize={25}
                      minValue={1}
                      maxValue={9999}
                      onDrag={(e, value) => act('setAngle', {
                        ref: value,
                      })} />
                </Section>
                <Section title="Set Power">
                {power_possible.map(power_choice => (
                  <Button
                    content={power_choice[0]}
                    color={power_choice[1] === 2 ? "green" : power_choice[1] ? "default" : "red"}
                    onClick={() => act('set_power', {
                      power: power_choice[0]
                    })}
                   />
                ))}
                </Section>
                <Section title="Set Sector">
                <NumberInput
                        key="sectorValue"
                        width="65px"
                        unit=""
                        value={z_coord}
                        step={1}
                        stepPixelSize={25}
                        minValue={1}
                        maxValue={10}
                        onDrag={(e, value) => act('setSector', {
                          ref: value,
                        })} />
                </Section>
                <Section title="Extra Functions">
                    <Button
                      content="Send"
                      onClick={() => act('send')}
                    />
                    <Button
                      content="Receive"
                      onClick={() => act('receive')}
                    />
                    <Button
                      content="Recalibrate Crystals"
                      onClick={() => act('recalibrate')}
                    />
                    <Button
                      content="Eject Crystals"
                      onClick={() => act('eject')}
                    />
                </Section>
                <Box color="green" backgroundColor="black">
                  Last teleportation data:<br />
                  {last_tele_data.length ? last_tele_data : "No teleport data found."}<br />
                </Box>
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
