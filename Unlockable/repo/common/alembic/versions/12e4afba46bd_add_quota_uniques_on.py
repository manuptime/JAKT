"""add quota_uniques on Campaign table

Revision ID: 12e4afba46bd
Revises: 305445859140  #33a11e4c3a5a
Create Date: 2013-10-11 20:06:33.806846

"""

# revision identifiers, used by Alembic.
revision = '12e4afba46bd'

down_revision = '305445859140' #'33a11e4c3a5a'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.add_column('campaign', sa.Column('quota_uniques', sa.Integer()))

def downgrade():
    op.drop_column('campaign', 'quota_uniques')
