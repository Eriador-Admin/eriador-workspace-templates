describe('Home Page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('should load the page', () => {
    cy.url().should('include', '/');
  });

  it('should have a heading', () => {
    cy.get('h1').should('exist');
  });

  it('should display content', () => {
    cy.get('body').should('not.be.empty');
  });
});
