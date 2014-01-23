"""add default zero on quota uniques

Revision ID: 2c3abb32729d
Revises: 12e4afba46bd
Create Date: 2013-10-11 20:25:27.174364

"""

# revision identifiers, used by Alembic.
revision = '2c3abb32729d'
down_revision = '12e4afba46bd'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.alter_column('campaign', 'quota_uniques', server_default='0') 


def downgrade():
    op.alter_column('campaign', 'quota_uniques', server_default=False) 
