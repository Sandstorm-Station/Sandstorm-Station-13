import { map } from 'common/collections';
import { useBackend, useLocalState } from '../backend';
import { BlockQuote, Button, Flex, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const MobInteraction = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    isTargetSelf,
    interactingWith,
    selfAttributes,
    theirAttributes,
  } = data;
  const [tabIndex, setTabIndex] = useLocalState(context, 'tabIndex', 0);

  return (
    <Window
      width={430}
      height={700}
      resizable>
      <Window.Content scrollable>
        <Section title={interactingWith}>
          <BlockQuote>
            You...<br />
            {selfAttributes.map(attribute => (
              <div key={attribute}>
                {attribute}<br />
              </div>
            ))}
          </BlockQuote>
          {!isTargetSelf ? (
            <BlockQuote>
              They...<br />
              {theirAttributes.map(attribute => (
                <div key={attribute}>
                  {attribute}<br />
                </div>
              ))}
            </BlockQuote>
          ) : (null)}
        </Section>
        <Section>
          <Tabs>
            <Tabs.Tab selected={tabIndex === 0} onClick={() => setTabIndex(0)}>
              Interactions
            </Tabs.Tab>
            <Tabs.Tab selected={tabIndex === 1} onClick={() => setTabIndex(1)}>
              Genital Visibility
            </Tabs.Tab>
            <Tabs.Tab selected={tabIndex === 2} onClick={() => setTabIndex(2)}>
              Character Prefs
            </Tabs.Tab>
            <Tabs.Tab selected={tabIndex === 3} onClick={() => setTabIndex(3)}>
              Preferences
            </Tabs.Tab>
          </Tabs>
          {tabIndex === 0 && (
            <InteractionsTab />
          ) || tabIndex === 1 && (
            <GenitalVisibilityTab />
          ) || tabIndex === 2 && (
            <CharacterPrefsTab />
          ) || tabIndex === 3 && (
            <ContentPreferencesTab />
          ) || ("Somehow, you've got into an invalid page, please report this.")}
        </Section>
      </Window.Content>
    </Window>
  );
};

const InteractionsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const interactions = data.interactions || [];
  return (
    interactions.length ? (
      <Flex direction="column">
        {interactions.map(interaction => (
          <Button
            key={interaction['key']}
            content={interaction['desc']}
            color={interaction['type'] === 2 ? "red" : interaction['type'] ? "pink" : "default"}
            onClick={() => act('interact', {
              interaction: interaction['key'],
            })} />
        ))}
      </Flex>
    ) : ("No interactions available")
  );
};

const ModeToIcon = {
  "Always visible": "eye",
  "Hidden by clothes": "tshirt",
  "Hidden by underwear": "low-vision",
  "Always hidden": "eye-slash",
};

const GenitalVisibilityTab = (props, context) => {
  const { act, data } = useBackend(context);
  const genitals = data.genitals || [];
  return (
    genitals.length ? (
      <Flex direction="column">
        <LabeledList>
          {genitals.map(genital => (
            <LabeledList.Item key={genital['key']} label={genital['name']}>
              {genital.possible_choices.map(choice => (
                <Button
                  key={choice}
                  tooltip={choice}
                  icon={ModeToIcon[choice]}
                  color={genital.visibility === choice ? "green" : "default"}
                  onClick={() => act('genital', {
                    genital: genital['key'],
                    visibility: choice,
                  })} />
              ))}
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Flex>
    ) : ("You don't seem to have any genitals... Or any that you could modify")
  );
};

const CharacterPrefsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    erp_pref,
    noncon_pref,
    vore_pref,
    extreme_pref,
    extreme_harm,
  } = data;
  return (
    <Flex direction="column">
      <LabeledList>
        <LabeledList.Item label="ERP Preference">
          <Button
            icon={"check"}
            color={erp_pref === 1 ? "green" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'erp_pref',
              value: 1,
            })} />
          <Button
            icon={"question"}
            color={erp_pref === 2 ? "yellow" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'erp_pref',
              value: 2,
            })} />
          <Button
            icon={"times"}
            color={erp_pref === 0 ? "red" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'erp_pref',
              value: 0,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Noncon Preference">
          <Button
            icon={"check"}
            color={noncon_pref === 1 ? "green" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'noncon_pref',
              value: 1,
            })} />
          <Button
            icon={"question"}
            color={noncon_pref === 2 ? "yellow" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'noncon_pref',
              value: 2,
            })} />
          <Button
            icon={"times"}
            color={noncon_pref === 0 ? "red" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'noncon_pref',
              value: 0,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Vore Preference">
          <Button
            icon={"check"}
            color={vore_pref === 1 ? "green" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'vore_pref',
              value: 1,
            })} />
          <Button
            icon={"question"}
            color={vore_pref === 2 ? "yellow" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'vore_pref',
              value: 2,
            })} />
          <Button
            icon={"times"}
            color={vore_pref === 0 ? "red" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'vore_pref',
              value: 0,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Extreme Preference">
          <Button
            icon={"check"}
            color={extreme_pref === 1 ? "green" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'extreme_pref',
              value: 1,
            })} />
          <Button
            icon={"question"}
            color={extreme_pref === 2 ? "yellow" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'extreme_pref',
              value: 2,
            })} />
          <Button
            icon={"times"}
            color={extreme_pref === 0 ? "red" : "default"}
            onClick={() => act('char_pref', {
              char_pref: 'extreme_pref',
              value: 0,
            })} />
        </LabeledList.Item>
        {extreme_pref ? (
          <LabeledList.Item label="Extreme Harm">
            <Button
              icon={"check"}
              color={extreme_harm === 1 ? "green" : "default"}
              onClick={() => act('char_pref', {
                char_pref: 'extreme_harm',
                value: 1,
              })} />
            <Button
              icon={"times"}
              color={extreme_harm === 0 ? "red" : "default"}
              onClick={() => act('char_pref', {
                char_pref: 'extreme_harm',
                value: 0,
              })} />
          </LabeledList.Item>
        ) : (null)}
      </LabeledList>
    </Flex>
  );
};

const ContentPreferencesTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    verb_consent,
    lewd_verb_sounds,
    arousable,
    genital_examine,
    vore_examine,
    medihound_sleeper,
    eating_noises,
    digestion_noises,
    trash_forcefeed,
    forced_fem,
    forced_masc,
    hypno,
    bimbofication,
    breast_enlargement,
    penis_enlargement,
    never_hypno,
    no_aphro,
    no_ass_slap,
    no_auto_wag,
  } = data;
  return (
    <Flex direction="column">
      <Button
        content="Allow lewd verbs"
        icon={verb_consent ? "toggle-on" : "toggle-off"}
        selected={verb_consent}
        onClick={() => act('pref', {
          pref: 'verb_consent',
        })}
      />
      <Button
        content="Lewd verb sounds"
        icon={lewd_verb_sounds ? "volume-up" : "volume-mute"}
        selected={lewd_verb_sounds}
        onClick={() => act('pref', {
          pref: 'lewd_verb_sounds',
        })}
      />
      <Button
        content="Arousal"
        icon={arousable ? "toggle-on" : "toggle-off"}
        selected={arousable}
        onClick={() => act('pref', {
          pref: 'arousable',
        })}
      />
      <Button
        content="Genital examine text"
        icon={genital_examine ? "toggle-on" : "toggle-off"}
        selected={genital_examine}
        onClick={() => act('pref', {
          pref: 'genital_examine',
        })}
      />
      <Button
        content="Vore examine text"
        icon={vore_examine ? "toggle-on" : "toggle-off"}
        selected={vore_examine}
        onClick={() => act('pref', {
          pref: 'vore_examine',
        })}
      />
      <Button
        content="Voracious Medihound sleepers"
        icon={medihound_sleeper ? "toggle-on" : "toggle-off"}
        selected={medihound_sleeper}
        onClick={() => act('pref', {
          pref: 'medihound_sleeper',
        })}
      />
      <Button
        content="Hear vore sounds"
        icon={eating_noises ? "volume-up" : "volume-mute"}
        selected={eating_noises}
        onClick={() => act('pref', {
          pref: 'eating_noises',
        })}
      />
      <Button
        content="Hear vore digestion sounds"
        icon={digestion_noises ? "volume-up" : "volume-mute"}
        selected={digestion_noises}
        onClick={() => act('pref', {
          pref: 'digestion_noises',
        })}
      />
      <Button
        content="Allow trash forcefeeding (requires Trashcan quirk)"
        icon={trash_forcefeed ? "toggle-on" : "toggle-off"}
        selected={trash_forcefeed}
        onClick={() => act('pref', {
          pref: 'trash_forcefeed',
        })}
      />
      <Button
        content="Forced feminization"
        icon={forced_fem ? "toggle-on" : "toggle-off"}
        selected={forced_fem}
        onClick={() => act('pref', {
          pref: 'forced_fem',
        })}
      />
      <Button
        content="Forced Masculinization"
        icon={forced_masc ? "toggle-on" : "toggle-off"}
        selected={forced_masc}
        onClick={() => act('pref', {
          pref: 'forced_masc',
        })}
      />
      <Button
        content="Lewd hypno"
        icon={hypno ? "toggle-on" : "toggle-off"}
        selected={hypno}
        onClick={() => act('pref', {
          pref: 'hypno',
        })}
      />
      <Button
        content="Bimbofication"
        icon={bimbofication ? "toggle-on" : "toggle-off"}
        selected={bimbofication}
        onClick={() => act('pref', {
          pref: 'bimbofication',
        })}
      />
      <Button
        content="Breast enlargement"
        icon={breast_enlargement ? "toggle-on" : "toggle-off"}
        selected={breast_enlargement}
        onClick={() => act('pref', {
          pref: 'breast_enlargement',
        })}
      />
      <Button
        content="Penis enlargement"
        icon={penis_enlargement ? "toggle-on" : "toggle-off"}
        selected={penis_enlargement}
        onClick={() => act('pref', {
          pref: 'penis_enlargement',
        })}
      />
      <Button
        content="Hypno"
        icon={never_hypno ? "toggle-on" : "toggle-off"}
        selected={never_hypno}
        onClick={() => act('pref', {
          pref: 'never_hypno',
        })}
      />
      <Button
        content="Aphrodisiacs"
        icon={no_aphro ? "toggle-on" : "toggle-off"}
        selected={no_aphro}
        onClick={() => act('pref', {
          pref: 'no_aphro',
        })}
      />
      <Button
        content="Ass slapping"
        icon={no_ass_slap ? "toggle-on" : "toggle-off"}
        selected={no_ass_slap}
        onClick={() => act('pref', {
          pref: 'no_ass_slap',
        })}
      />
      <Button
        content="Automatic wagging"
        icon={no_auto_wag ? "toggle-on" : "toggle-off"}
        selected={no_auto_wag}
        onClick={() => act('pref', {
          pref: 'no_auto_wag',
        })}
      />
    </Flex>
  );
};
