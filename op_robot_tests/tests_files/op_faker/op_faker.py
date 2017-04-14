# -*- coding: utf-8 -*-
from faker.providers import BaseProvider
from copy import deepcopy
from munch import Munch
from json import load
import os


def load_data_from_file(file_name):
    if not os.path.exists(file_name):
        file_name = os.path.join(os.path.dirname(__file__), file_name)
    with open(file_name) as file_obj:
        if file_name.endswith(".json"):
            return Munch.fromDict(load(file_obj))
        elif file_name.endswith(".yaml"):
            return Munch.fromYAML(file_obj)


class OP_Provider(BaseProvider):
    __fake_data = load_data_from_file("op_faker_data.json")
    word_list = __fake_data.words
    procuringEntities = __fake_data.procuringEntities
    procuringEntities_other = __fake_data.procuringEntities_other
    addresses = __fake_data.addresses
    classifications_other = __fake_data.classifications_other
    cpvs_other = __fake_data.cpvs_other
    items_base_data_other = __fake_data.items_base_data_other
    classifications_financial = __fake_data.classifications_financial
    cpvs_financial = __fake_data.cpvs_financial
    items_base_data_financial = __fake_data.items_base_data_financial
    additionalIdentifiers = __fake_data.additionalIdentifiers

    @classmethod
    def randomize_nb_elements(self, number=10, le=60, ge=140):
        """
        Returns a random value near number.

        :param number: value to which the result must be near
        :param le: lower limit of randomizing (percents). Default - 60
        :param ge: upper limit of randomizing (percents). Default - 140
        :returns: a random int in range [le * number / 100, ge * number / 100]
            with minimum of 1
        """
        if le > ge:
            raise Exception("Lower bound: {} is greater then upper: {}.".format(le, ge))
        return int(number * self.random_int(min=le, max=ge) / 100) + 1

    @classmethod
    def word(self):
        """
        :example 'Курка'
        """
        return self.random_element(self.word_list)

    @classmethod
    def words(self, nb=3):
        """
        Generate an array of random words
        :example: array('Надіньте', 'фуражка', 'зелено')
        :param nb: how many words to return
        """
        return [self.word() for _ in range(0, nb)]

    @classmethod
    def sentence(self, nb_words=5, variable_nb_words=True):
        """
        Generate a random sentence
        :example: 'Курка надіньте пречудовий зелено на.'
        :param nb_words: how many words the sentence should contain
        :param variable_nb_words: set to false if you want exactly $nbWords returned,
            otherwise $nbWords may vary by +/-40% with a minimum of 1
        """
        if nb_words <= 0:
            return ''

        if variable_nb_words:
            nb_words = self.randomize_nb_elements(number=nb_words)

        words = self.words(nb_words)
        words[0] = words[0].title()

        return " ".join(words) + '.'

    @classmethod
    def title(self):
        return self.sentence(nb_words=3)

    @classmethod
    def dgfID(self):
        return "{}{}-{:05d}".format("F", self.random_int(10000000, 99999999),
                                    self.random_int(1000, 99999))
    @classmethod
    def dgfDecisionID(self):
        return "{}/{}".format(2233, self.random_int(1, 9))

    @classmethod
    def description(self):
        return self.sentence(nb_words=10)

    @classmethod
    def procuringEntity(self):
        return deepcopy(self.random_element(self.procuringEntities))

    @classmethod
    def procuringEntity_other(self):
        procuringEntities = deepcopy(self.procuringEntities)
        procuringEntities.extend(self.procuringEntities_other)
        return deepcopy(self.random_element(procuringEntities))

    @classmethod
    def cpv_other(self):
        return self.random_element(self.cpvs_other)

    @classmethod
    def cpv_financial(self):
        return self.random_element(self.cpvs_financial)

    @classmethod
    def additionalIdentifier(self):
        return self.random_element(self.additionalIdentifiers)

    @classmethod
    def fake_item(self, cpv_group):
        # """
        # Generate a random item for openprocurement tenders

        # :param cav_group: gives possibility to generate items
        #     from a specific cav group. cav group is three digits
        #     in the beginning of each cav id.
        # """
        # for dgf other mode, and all other modes besides dgf financial
        # generates items from dgf_other CAV group
        cpv_group = str(cpv_group)
        similar_cpvs = []
        for cpv_element in self.classifications_other:
            if cpv_element["classification"]["id"].startswith(cpv_group):
                similar_cpvs.append(cpv_element)
        cpv = self.random_element(similar_cpvs)["classification"]["id"]
        for entity in self.items_base_data_other:
            if entity["cpv_id"] == cpv:
                item_base_data = entity
                break
        for entity in self.classifications_other:
            if entity["classification"]["id"] == item_base_data["cpv_id"]:
                classification = entity
                break

        address = self.random_element(self.addresses)
        item = {
            "description": item_base_data["description"],
            "description_ru": item_base_data["description_ru"],
            "description_en": item_base_data["description_en"],
            "classification": classification["classification"],
            "deliveryAddress": address["deliveryAddress"],
            "deliveryLocation": address["deliveryLocation"],
            "unit": item_base_data["unit"],
            "quantity": self.randomize_nb_elements(number=item_base_data["quantity"], le=80, ge=120)
        }
        return deepcopy(item)

    @classmethod
    def fake_item_financial(self, cpv_group):
        # for dgf financial assets mode
        # generates items from financial CAV group
        cpv_group = str(cpv_group)
        similar_cpvs = []
        for cpv_element in self.classifications_financial:
            if cpv_element["classification"]["id"].startswith(cpv_group):
                similar_cpvs.append(cpv_element)
        cpv = self.random_element(similar_cpvs)["classification"]["id"]
        for entity in self.items_base_data_financial:
            if entity["cpv_id"] == cpv:
                item_base_data = entity
                break
        for entity in self.classifications_financial:
            if entity["classification"]["id"] == item_base_data["cpv_id"]:
                classification = entity
                break

        address = self.random_element(self.addresses)
        item = {
            "description": item_base_data["description"],
            "description_ru": item_base_data["description_ru"],
            "description_en": item_base_data["description_en"],
            "classification": classification["classification"],
            "deliveryAddress": address["deliveryAddress"],
            "deliveryLocation": address["deliveryLocation"],
            "unit": item_base_data["unit"],
            "quantity": self.randomize_nb_elements(number=item_base_data["quantity"], le=80, ge=120)
        }
        return deepcopy(item)
