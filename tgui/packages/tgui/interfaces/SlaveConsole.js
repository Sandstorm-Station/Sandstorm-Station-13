import { map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { vecLength, vecSubtract } from 'common/vector';
import { shallowDiffers } from '../../common/react';
import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table, Flex, Stack } from '../components';
import { Window } from '../layouts';

const coordsToVec = coords => map(parseFloat)(coords.split(', '));

export const SlaveConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    currentCoords,
  } = data;
  const slaves = flow([
    map((slave, index) => {
      // Calculate distance to the target. BYOND distance is capped to 127,
      // that's why we roll our own calculations here.
      const dist = slave.dist && (
        Math.round(vecLength(vecSubtract(
          coordsToVec(currentCoords),
          coordsToVec(slave.coords))))
      );
      return { ...slave, dist, index };
    }),
    sortBy(
      slave => slave.name), // Sort alphabetically
  ])(data.slaves || []);
  return (
    <Window
      title="Slave Management System"
      width={470}
      height={700}
      resizable>
      <Window.Content scrollable>
        <Section title="Funds">
          <Box fontSize="18px">
            12345
          </Box>
        </Section>

        <Section title="Funds">
          <Box>
            12345
          </Box>
        </Section>

        <Section title="Funds">
          12345
        </Section>

        <Section title="Functions">
          <Flex direction="column">
            <Button
              icon="bullhorn"
              content="Make Priority Announcement"
              onClick={() => act("makePriorityAnnouncement")}
            />
            <Button
              icon="shopping-cart"
              content="Purchase Supplies"
              onClick={() => act("purchaseSupplies")}
            />
          </Flex>
        </Section>

        <Section title="Slaves">
          <Stack
            justify="space-between">
            {slaves.map(slave => (
              <Stack.Item
                key={slave.name + slave.coords + slave.index}>
                <Flex>
                  <Flex.Item>
                    {slave.name}
                  </Flex.Item>

                  <Flex.Item>
                    {slave.degrees !== undefined && (
                      <Icon
                        mr={1}
                        size={1.2}
                        name="arrow-up"
                        rotation={slave.degrees} />
                    )}
                    {slave.dist !== undefined && (
                      slave.dist + 'm'
                    )}
                    <Button
                      icon="dollar-sign"
                      content="1000"
                      onClick={() => act("makePriorityAnnouncement")} />
                  </Flex.Item>
                </Flex>
              </Stack.Item>
            ))}
          </Stack>
        </Section>

        <Section title="Slaves Table">
          <Table>
            {slaves.map(slave => (
              <Table.Row
                key={slave.name + slave.coords + slave.index}
                className="candystripe">

                <Table.Cell bold color="label">
                  {slave.name}
                </Table.Cell>

                <Table.Cell
                  collapsing>
                  {slave.degrees !== undefined && (
                    <Icon
                      mr={1}
                      size={1.2}
                      name="arrow-up"
                      rotation={slave.degrees} />
                  )}
                  {slave.dist !== undefined && (
                    slave.dist + 'm'
                  )}
                </Table.Cell>

                <Table.Cell
                  collapsing>
                  <Button
                    icon="dollar-sign"
                    content="1000"
                    onClick={() => act("makePriorityAnnouncement")} />
                </Table.Cell>

                <Table.Cell
                  collapsing>
                  <Button
                    icon="dollar-sign"
                    content="1000 advanced"
                    onClick={() => act('toggleBought', {
                      id: slave.id,
                    })} />
                </Table.Cell>

              </Table.Row>
            ))}
          </Table>
        </Section>

        <Section title="Slaves Table">
          <Table>
            {slaves.map(slave => (
              <Table.Row
                key={slave.name + slave.coords + slave.index}
                className="candystripe">

                <Table.Cell bold color="label">
                  {slave.name}
                </Table.Cell>

                <Table.Cell>
                  {slave.degrees !== undefined && (
                    <Icon
                      mr={1}
                      size={1.2}
                      name="arrow-up"
                      rotation={slave.degrees} />
                  )}
                  {slave.dist !== undefined && (
                    slave.dist + 'm'
                  )}
                </Table.Cell>

                <Table.Cell>
                  <Button
                    icon="dollar-sign"
                    content="1000"
                    onClick={() => act("makePriorityAnnouncement")} />
                </Table.Cell>

                <Table.Cell>
                  <Button
                    icon="dollar-sign"
                    content="1000 advanced"
                    onClick={() => act('toggleBought', {
                      id: slave.id,
                    })} />
                </Table.Cell>

              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
