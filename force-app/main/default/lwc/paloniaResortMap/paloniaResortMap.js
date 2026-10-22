import { LightningElement, api, wire } from 'lwc';
import getMapData from '@salesforce/apex/PaloniaResortMapController.getMapData';

const TYPE_STYLES = {
    Snorkeling: { color: '#087e8b', icon: '🤿' },
    'Whale Watching': { color: '#176b87', icon: '🐋' },
    Surfing: { color: '#d05a38', icon: '🏄' },
    Paddleboarding: { color: '#168c9a', icon: '🛶' },
    'Sunset Sail': { color: '#b45f24', icon: '⛵' },
    'Eco Tour': { color: '#39764a', icon: '🌿' },
    'Spa & Wellness': { color: '#9862a5', icon: '🧘' },
    Dining: { color: '#b44350', icon: '🍽️' },
    'Family Activities': { color: '#ba7a19', icon: '👨‍👩‍👧' },
    Fitness: { color: '#315e9b', icon: '💪' }
};

export default class PaloniaResortMap extends LightningElement {
    @api recordId;

    mapData;
    selectedExperience;
    errorMessage;

    @wire(getMapData, { guestId: '$recordId' })
    wiredMapData({ data, error }) {
        if (data) {
            this.mapData = data;
            this.errorMessage = undefined;
            this.selectedExperience = undefined;
        } else if (error) {
            this.mapData = undefined;
            this.errorMessage = this.reduceError(error);
        }
    }

    get isLoading() {
        return !this.mapData && !this.errorMessage;
    }

    get mapExperiences() {
        if (!this.mapData) {
            return [];
        }

        const interests = new Set(
            (this.mapData.interests || [])
                .filter((interest) => interest)
                .map((interest) => interest.toLocaleLowerCase())
        );

        return this.mapData.experiences
            .filter(
                (experience) =>
                    Number.isFinite(experience.Map_X__c) &&
                    Number.isFinite(experience.Map_Y__c) &&
                    experience.Map_X__c >= 0 &&
                    experience.Map_X__c <= 100 &&
                    experience.Map_Y__c >= 0 &&
                    experience.Map_Y__c <= 100
            )
            .map((experience) => {
                const typeStyle = TYPE_STYLES[experience.Type__c] || {
                    color: '#52616b',
                    icon: '📍'
                };
                const isRecommended =
                    experience.Type__c &&
                    interests.has(experience.Type__c.toLocaleLowerCase());

                return {
                    ...experience,
                    color: typeStyle.color,
                    icon: typeStyle.icon,
                    transform: `translate(${experience.Map_X__c} ${experience.Map_Y__c})`,
                    pinClass: `experience-pin ${isRecommended ? 'recommended' : 'dimmed'}`,
                    ariaLabel: `${experience.Name}, ${experience.Type__c || 'Experience'}${
                        isRecommended ? ', matches guest interests' : ''
                    }`,
                    typeStyle: `--type-color: ${typeStyle.color}`,
                    isRecommended,
                    hasDuration:
                        experience.Duration_Hours__c !== null &&
                        experience.Duration_Hours__c !== undefined,
                    activityLevel: experience.Activity_Level__c || 'Not specified',
                    location: experience.Location__c || 'Not specified'
                };
            });
    }

    get hasExperiences() {
        return this.mapExperiences.length > 0;
    }

    get hasNoExperiences() {
        return !this.hasExperiences;
    }

    handlePinClick(event) {
        const experienceId = event.currentTarget.dataset.experienceId;
        this.selectedExperience = this.mapExperiences.find(
            (experience) => experience.Id === experienceId
        );
    }

    handlePinKeydown(event) {
        if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            this.handlePinClick(event);
        }
    }

    handleCloseDetails() {
        this.selectedExperience = undefined;
    }

    reduceError(error) {
        if (Array.isArray(error.body)) {
            return error.body.map((item) => item.message).join(', ');
        }
        return error.body?.message || error.message || 'Unable to load the resort map.';
    }
}
