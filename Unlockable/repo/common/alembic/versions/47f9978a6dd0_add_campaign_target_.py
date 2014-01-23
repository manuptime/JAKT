"""add campaign_target table

Revision ID: 47f9978a6dd0
Revises: 3a7bb192fb7f
Create Date: 2013-10-12 11:59:44.808454

"""

# revision identifiers, used by Alembic.
revision = '47f9978a6dd0'
down_revision = '3a7bb192fb7f'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.create_table(
        'campaign_target',
        sa.Column('id', sa.Integer, primary_key=True),
        sa.Column('age', sa.String(5)),
        sa.Column('gender', sa.String(6)),
        sa.Column('children', sa.String(3)),
        sa.Column('zip', sa.String(5)),
        sa.Column('household_income', sa.String(22)),
        sa.Column('new_players_only', sa.Boolean()),
    )

def downgrade():
     op.drop_table('campaign_target')

