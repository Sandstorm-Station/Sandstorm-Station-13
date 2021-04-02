import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput } from '../components';
import { Window } from '../layouts';

export const Telesci = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    telepad,
    inserted_gps,
    temp_msg,
    rotation,
    angle,
    power,
    z_coord,
    last_tele_data,
  } = data;
  return (
    <Window
      width={360}
      height={620}>
      <Window.Content>
        <Section title="Telepad Control Console">
          {!telepad && (
            <Box color="bad" textAlign="center" backgroundColor="black">
              No telepad located.<br />
              Please add telepad data.
            </Box>
          ) || (
            <LabeledList>
              <LabeledList.Item label="GPS">
                <Button
                  content="Eject GPS"
                  disabled={!inserted_gps}
                  onClick={() => act('eject_gps')} />
              </LabeledList.Item>
              <LabeledList.Item label="Info">
                <Box>
                  {temp_msg}
                </Box>
              </LabeledList.Item>
              <LabeledList.Item label="Set Bearing">
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
              </LabeledList.Item>
              <LabeledList.Item label="Set Elevation">
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
              </LabeledList.Item>
              <LabeledList.Item label="Set Power">
                <NumberInput
                        key="powerValue"
                        width="65px"
                        unit="kW"
                        value={power}
                        step={5}
                        stepPixelSize={25}
                        minValue={5}
                        maxValue={100}
                        onDrag={(e, value) => act('setPower', {
                          ref: value,
                        })} />
              </LabeledList.Item>
              <LabeledList.Item label="Set Sector">
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
              </LabeledList.Item>
              <LabeledList.Item label="Extra Functions">
                <Section>
                  <Section.Item>
                    <Button
                      content="Send"
                      onClick={() => act('send')}
                    />
                  </Section.Item>
                  <Section.Item>
                    <Button
                      content="Receive"
                      onClick={() => act('receive')}
                    />
                  </Section.Item>
                  <Section.Item>
                    <Button
                      content="Recalibrate Crystals"
                      onClick={() => act('recalibrate')}
                    />
                  </Section.Item>
                  <Section.Item>
                    <Button
                      content="Eject Crystals"
                      onClick={() => act('eject')}
                    />
                  </Section.Item>
                </Section>
              </LabeledList.Item>
              <LabeledList.Item label="Last Teleport Data">
                <Box>
                  {last_tele_data ? last_tele_data : "No teleport data found."}
                </Box>
              </LabeledList.Item>
            </LabeledList>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
