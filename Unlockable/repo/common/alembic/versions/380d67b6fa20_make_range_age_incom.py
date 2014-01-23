"""make range age income on campaign target

Revision ID: 380d67b6fa20
Revises: 47f9978a6dd0
Create Date: 2013-10-12 12:20:21.933436

"""

# revision identifiers, used by Alembic.
revision = '380d67b6fa20'
down_revision = '47f9978a6dd0'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.drop_column('campaign_target', 'age')
    op.drop_column('campaign_target', 'household_income')

    op.add_column('campaign_target', sa.Column('min_age', sa.String(5)))
    op.add_column('campaign_target', sa.Column('max_age', sa.String(5)))
    op.add_column('campaign_target', sa.Column('min_household_income', sa.String(22)))
    op.add_column('campaign_target', sa.Column('max_household_income', sa.String(22)))

def downgrade():
    op.add_column('campaign_target', sa.Column('age', sa.String(5)))
    op.add_column('campaign_target', sa.Column('household_income', sa.String(22)))

    op.drop_column('campaign_target', 'min_age')
    op.drop_column('campaign_target', 'max_age')
    op.drop_column('campaign_target', 'min_household_income')
    op.drop_column('campaign_target', 'max_household_income')

