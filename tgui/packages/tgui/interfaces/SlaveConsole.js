import { map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { vecLength, vecSubtract } from 'common/vector';
import { useBackend, useSharedState } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Flex, Tabs, NoticeBox, Fragment } from '../components';
import { Window } from '../layouts';
import { GenericUplink } from './Uplink';

const coordsToVec = coords => map(parseFloat)(coords.split(', '));

export const SlaveConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useSharedState(context, 'tab', 1);
  const {
    credits,
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
        <Section>
          <Flex direction="column">
            <Button
              icon="bullhorn"
              content="Send transmission to the station"
              onClick={() => act("makePriorityAnnouncement")}
            />
          </Flex>
        </Section>

        <Tabs>
          <Tabs.Tab
            icon="link"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Slave Management
          </Tabs.Tab>
          <Tabs.Tab
            icon="shopping-cart"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Supplies
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <SlavePanel
            slaves={slaves} />
        )}
        {tab === 2 && (
          <SupplyPanel
            credits={credits} />
        )}

      </Window.Content>
    </Window>
  );
};

const SlavePanel = (props, context) => {
  const { slaves } = props;
  const { act, data } = useBackend(context);
  if (!slaves.length) {
    return (
      <NoticeBox>
        No slaves detected in hideout
      </NoticeBox>
    );
  }
  return slaves.map(slave => {
    return (
      <Section
        key={slave.id}
        title={slave.name}
        buttons={(
          <Fragment>
            <Button
              icon="dolly"
              content="Export"
              color="good"
              disabled={!slave.bought || !slave.inexportbay}
              tooltip="Send the slave back to the station. First the ransom must be paid by the station, and the slave must be in the export bay."
              onClick={() => act('export', {
                id: slave.id,
              })} />
            <Button
              icon="bolt"
              color="average"
              content="Shock"
              disabled={slave.dist === undefined || slave.shockcooldown}
              onClick={() => act('shock', {
                id: slave.id,
              })} />
            <Button.Confirm
              icon="unlock"
              content="Release"
              color="bad"
              disabled={slave.dist === undefined}
              tooltip="Remove the slave's collar.        "
              onClick={() => act('release', {
                id: slave.id,
              })} />
          </Fragment>
        )}>
        <LabeledList>
          <LabeledList.Item
            label="State"
            color={slave.statstate}>
            {slave.stat}
          </LabeledList.Item>
          <LabeledList.Item
            label="Location">
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
            {slave.degrees === undefined && (
              <Box color="bad">
                Out of range
              </Box>
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Price">
            {!slave.price && (
              <Button
                icon="pencil-alt"
                content="Set price"
                tooltip="The station will have to pay this to get the slave back."
                onClick={() => act('setPrice', {
                  id: slave.id,
                })} />
            )}
            {!!slave.price && (
              <Box>
                {slave.price}cr
              </Box>
            )}
          </LabeledList.Item>
          <LabeledList.Item
            label="Ransom"
            color={!slave.price
              ? "bad"
              : !slave.bought
                ? 'average'
                : 'good'}
          >
            {!slave.price
              ? "Set the price"
              : !slave.bought
                ? 'Awaiting payment from station'
                : 'Paid; Ready for export'}
          </LabeledList.Item>
        </LabeledList>
      </Section>
    );
  });
};

const SupplyPanel = (props, context) => {
  const { credits } = props;
  return (
    <GenericUplink
      currencyAmount={credits}
      currencySymbol="Credits" />
  );
};
