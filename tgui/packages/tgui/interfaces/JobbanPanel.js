import { Fragment } from "inferno";
import { useBackend, useLocalState } from '../backend';
import { Input, Collapsible, Button, Flex, Section, Tabs, Box, Dropdown, Slider, Tooltip, NoticeBox, Blink } from '../components';
import { Window } from '../layouts';

export const JobbanPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 0);
  // const PageComponent = PAGES[pageIndex].component();
  const { roles, client_ckey } = data;

  return (
    <Window
      title={`${client_ckey} Jobban Panel`}
      width={450}
      height={600}
    >
      <Window.Content scrollable>
        <Flex>
          <Flex.Item>
            <Section fitted>
              <Tabs vertical>
                {roles.map((role_category, i) => { return (
                  <Tabs.Tab
                    key={role_category.category_name}
                    color={role_category.category_color}
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
  const { roles, is_antag_banned } = data;
  return (
    <Section fill>
      <Section
        title={roles[tab].category_name}
        buttons={(
          <Fragment>
            <Button
              content="Ban All"
              color="bad"
              icon="lock"
              minWidth="8rem"
              textAlign="center"
              onClick={() => act(null, {
                selected_role: roles[tab].category_name,
                is_category: true,
                want_to_ban: true,
              })} />
            <Button
              content="Unban All"
              color="good"
              icon="lock-open"
              minWidth="8rem"
              textAlign="center"
              onClick={() => act(null, {
                selected_role: roles[tab].category_name,
                is_category: true,
              })} />
          </Fragment>
        )}
      >
        <Flex wrap="wrap">
          {/* is_antag_banned */}
          {roles[tab].category_name === "Antagonists" && (
            <NoticeBox
              width="100%"
              danger={is_antag_banned ? true : false}
            >
              <Flex justify="space-between" align="center">
                <Flex.Item width="100%">
                  This player is {is_antag_banned ? "" : "not"} antagonist banned
                </Flex.Item>
                <Flex.Item>
                  <Button
                    align="right"
                    ml=".5rem"
                    px="2rem"
                    py=".5rem"
                    color={is_antag_banned ? "orange" : ""}
                    content={is_antag_banned ? "Unban" : "Ban"}
                    onClick={() => act(null, {
                      selected_role: "Syndicate",
                      want_to_ban: (is_antag_banned ? false : true),
                    })}
                  />
                </Flex.Item>
              </Flex>
            </NoticeBox>
          )}

          {roles[tab].category_roles.map((role) => { return (
            <Flex.Item
              key={0}
              width="100%"
            >

              <Button
                width="100%"
                py=".5rem"
                mb=".5rem"
                icon={role.is_banned ? "lock" : "lock-open"}
                color={role.is_banned ? "bad" : "transparent"}
                content={role.name}
                onClick={() => act(null, {
                  selected_role: role.name,
                  want_to_ban: (role.is_banned ? false : true),
                })} />

              {role.is_banned && (
                <Collapsible
                  title="Reason"
                  py=".25rem"
                  color="orange"
                >
                  <Box px=".25rem" py=".5rem">
                    {role.ban_reason}
                  </Box>
                </Collapsible>
              )}

            </Flex.Item>
          ); })}

        </Flex>
      </Section>
    </Section>
  );
};
