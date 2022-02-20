import { Fragment } from "inferno";
import { useBackend, useLocalState } from '../backend';
import { Input, Button, Flex, Section, Tabs, Box, Dropdown, Slider, Tooltip } from '../components';
import { Window } from '../layouts';

export const JobbanPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 0);
  // const PageComponent = PAGES[pageIndex].component();
  const { roles, client_ckey } = data;

  return (
    <Window
      title={`${client_ckey} Jobban Panel`}
      width={500}
      height={500}
    >
      <Window.Content scrollable>
        <Flex grow>
          <Flex.Item>
            <Section fitted>
              <Tabs vertical>
                {roles.map((role_category, i) => { return (
                  <Tabs.Tab
                    key={role_category.category_name}
                    color="red"
                    py=".5rem"
                    selected={tab === i}
                    onClick={() => setTab(i)}>
                    {role_category.category_name}
                  </Tabs.Tab>
                ); })}
              </Tabs>
            </Section>
          </Flex.Item>
          <Flex.Item grow>
            <GeneralActions />
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const GeneralActions = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab] = useLocalState(context, 'tab', 0);
  const { roles, client_key } = data;
  return (
    <Section fill>
      <Section
        level={2}
        title={roles[tab].category_name}
        buttons={(
          <Fragment>
            <Button
              content="Ban All"
              color="bad"
              icon="lock"
              minWidth="8rem"
              textAlign="center"
              onClick={() => act('add_ban', {
                selected_role: roles[tab].category_name,
                is_category: true,
              })} />
            <Button
              content="Unban All"
              color="good"
              icon="lock-open"
              minWidth="8rem"
              textAlign="center"
              onClick={() => act('add_ban', {
                selected_role: roles[tab].category_name,
                is_category: true,
              })} />
          </Fragment>
        )}
      >
        <Flex grow={1} wrap="wrap">

          {roles[tab].category_roles.map((role) => { return (
            <Flex.Item
              key={0}
              width="100%"
              mb=".5rem"
            >
              {/* {role.is_banned = false}

              {role.name === "Virologist" && (
                role.is_banned = true
              )} */}

              <Button
                width="100%"
                py=".5rem"
                icon={role.is_banned ? "lock" : "lock-open"}
                color={role.is_banned ? "bad" : "transparent"}
                content={role.name}
                onClick={() => act("add_ban", {
                  selected_role: role.name,
                })}
              />
            </Flex.Item>
          ); })}

        </Flex>
      </Section>
    </Section>
  );
};
